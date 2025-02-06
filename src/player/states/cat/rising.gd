class_name RisingState extends State

func enter():
	animations.play("cat_rise")

func exit():
	pass

func process(delta: float):
	
	parent.handle_movement()

	parent.velocity.y += parent.gravity * delta
	if parent.velocity.y > 0:
		transition_to("falling")

func process_input(e: InputEvent):
	if e.is_action_pressed("jump"):
		parent.perform_jump()
		transition_to("rising")

	if e.is_action_pressed("dash"):
		parent.perform_dash()
