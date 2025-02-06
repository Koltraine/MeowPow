class_name WalkingState extends State


func enter():
	animations.play("cat_run")
	parent.reset_jumps()

func exit():
	pass

func process(_delta: float):
	parent.handle_movement()

	if !parent.is_on_floor():
		transition_to("falling")

	if parent.velocity.x == 0:
		transition_to("idle")


func process_input(e: InputEvent):
	if e.is_action_pressed("jump"):
		parent.perform_jump()
		transition_to("rising")

	if e.is_action_pressed("dash"):
		parent.perform_dash()