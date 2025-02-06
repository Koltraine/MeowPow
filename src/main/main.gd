extends CanvasLayer

var game_scene = preload("res://scenes/world/world.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()
