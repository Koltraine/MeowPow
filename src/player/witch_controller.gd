class_name WitchController extends CharacterBody2D

@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurt_box: HurtBox = $HurtBox
@onready var collision: CollisionShape2D = $CollisionShape2D

var witch_sm: SM

var is_active: bool = false

func _ready() -> void:
	witch_sm = SM.new(self, animations)
	witch_sm.add_state(ConjuringState.new("conjuring"))
	witch_sm.add_state(CastBeamState.new("cast_beam"))
	witch_sm.add_state(CastProjectileState.new("cast_projectile"))
	witch_sm.add_state(CastSpawnState.new("cast_spawn"))


func _physics_process(delta: float) -> void:
	if is_active:
		witch_sm.process(delta)

		if !is_on_floor():
			velocity.y += (gravity / 10) * delta
		move_and_slide()


func enable() -> void:
	visible = true
	hurt_box.monitorable = true
	collision.disabled = false
	is_active = true

func disable() -> void:
	visible = false
	hurt_box.monitorable = false
	collision.disabled = true
	is_active = false
