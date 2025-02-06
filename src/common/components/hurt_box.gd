class_name HurtBox extends Area2D

signal got_hit(value: float)

func _ready() -> void:
	monitorable = true
	monitoring = false

func take_hit(damage: float) -> void:
	got_hit.emit(damage)
