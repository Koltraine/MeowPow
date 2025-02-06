class_name CatInactiveState extends State

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(e: InputEvent) -> void:
	if e.is_action_pressed("switch_form"):
		if parent.is_on_floor():
			transition_to("idle")
		else:
			transition_to("falling")