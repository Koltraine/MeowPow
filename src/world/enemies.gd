extends Node

var SPAWN_DIST = 250
@export var player: PlayerController = null
@export var map: TileMapLayer = null

@onready var spawn_timer = $SpawnTimer

var enemy_scene = preload("res://scenes/enemies/enemy1.tscn")

func _on_spawn_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.player = player
	var spawn_position = player.position + Vector2(SPAWN_DIST, 0).rotated(randf() * TAU)
	
	while true:
		var cell = map.get_cell_source_id(map.local_to_map(spawn_position))
		if cell == -1:
			enemy.position = spawn_position
			break
		spawn_position = player.position + Vector2(SPAWN_DIST, 0).rotated(randf() * TAU)
		
	add_child(enemy)
