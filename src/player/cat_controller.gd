class_name CatController extends CharacterBody2D

@export var DASH_DISTANCE: float = 400.0
@export var SPEED: float = 80.0
@export var JUMP_VELOCITY: float = -225.0
@export var MOVING_DASH_DURATION: float = 0.2
@export var NEUTRAL_DASH_DURATION: float = 1.0
@export var MAX_JUMP_COUNT: int = 1

@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash_timer: Timer = $DashTimer
@onready var hurt_box: HurtBox = $HurtBox
@onready var collision: CollisionShape2D = $CollisionShape2D

var current_jump_count: int = MAX_JUMP_COUNT

var is_active: bool = false

var cat_sm: SM

func _ready() -> void:

	cat_sm = SM.new(self, animations)
	cat_sm.add_state(IdleState.new("idle"))
	cat_sm.add_state(WalkingState.new("walking"))
	cat_sm.add_state(JumpingState.new("jumping"))
	cat_sm.add_state(FallingState.new("falling"))
	cat_sm.add_state(RisingState.new("rising"))
	cat_sm.add_state(DashingState.new("dashing"))
	cat_sm.add_state(WallSlidingState.new("wall_sliding"))
	
func _physics_process(delta: float) -> void:
	if is_active:
		cat_sm.process(delta)
		move_and_slide()


func _input(e: InputEvent) -> void:
	cat_sm.process_input(e)

# Movement functions
func handle_movement():
	var direction: float = Input.get_axis("left", "right")

	if direction != 0:
		velocity.x = direction * SPEED
		animations.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func reset_jumps():
	current_jump_count = MAX_JUMP_COUNT

func perform_jump():
	if current_jump_count > 0:
		velocity.y = JUMP_VELOCITY
		animations.play("cat_jump")
		current_jump_count -= 1

func perform_dash():
	var direction: Vector2 = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

	var prev_state = cat_sm.current_state.state_name

	# if !is_on_floor():
	# 	if stamina < 1.0:
	# 		cat_sm._transition(prev_state)
	# 		return
	# 	stamina -= 1.0

	cat_sm._transition("dashing")

	if direction != Vector2.ZERO:
		velocity = direction * DASH_DISTANCE
		dash_timer.start(MOVING_DASH_DURATION)
	else:
		velocity = Vector2.ZERO
		dash_timer.start(NEUTRAL_DASH_DURATION)
	
	await dash_timer.timeout

	velocity = Vector2.ZERO
	cat_sm._transition(prev_state)
