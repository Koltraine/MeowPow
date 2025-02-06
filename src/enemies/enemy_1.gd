extends CharacterBody2D

@export var player: Node = null

@onready var animations = $AnimatedSprite2D

const SPEED = 100
const DASH_SPEED = 400
const DASH_DISTANCE = 60
const STOP_FRAMES = 30
const DASH_FRAMES = 10


@onready var dash_line = $Line2D

var frame_counter = 0
var is_dashing = false
var is_stopping = false
var dash_dir = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animations.play("chasing")


func _physics_process(_delta: float) -> void:
	var player_direction = (player.global_position - global_position).normalized()

	if is_stopping:
		if frame_counter == 0:
			dash_line.set_deferred("visible", true)
			dash_dir = player_direction
		if frame_counter < STOP_FRAMES:
			frame_counter += 1
			velocity = Vector2.ZERO
			if frame_counter == STOP_FRAMES:
				dash_line.set_deferred("visible", false)
		else:
			is_stopping = false
			is_dashing = true
			frame_counter = 0
	elif is_dashing:
		if frame_counter == 0:
			velocity = dash_dir * DASH_SPEED
			frame_counter += 1
		elif frame_counter < DASH_FRAMES:
			frame_counter += 1
		else:
			is_dashing = false
			frame_counter = 0
	else:
		var distance_to_player = global_position.distance_to(player.global_position)
		look_at(player.global_position)
		if distance_to_player < DASH_DISTANCE:
			is_stopping = true
			frame_counter = 0
		else:
			velocity = player_direction * SPEED
	
	move_and_slide()
