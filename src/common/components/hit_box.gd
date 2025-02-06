class_name HitBox extends Area2D

@export var damage: float = 0

func _ready() -> void:
	monitorable = false
	monitoring = true
	area_entered.connect(_on_area_entered)
	

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_hit"):
		area.take_hit(damage)
