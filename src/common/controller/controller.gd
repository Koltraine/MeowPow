class_name Controller extends RefCounted

var parent: CharacterBody2D
var controller_sm: SM

func _init(character: CharacterBody2D, animations: AnimatedSprite2D) -> void:
	self.parent = character
	controller_sm = SM.new(character, animations)

func process(delta: float) -> void:
	controller_sm.process(delta)

func process_input(e: InputEvent) -> void:
	controller_sm.process_input(e)

func die() -> void:
	pass