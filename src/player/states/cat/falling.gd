class_name FallingState extends State

func enter():
	animations.play("cat_fall")

func exit():
	pass

func process(delta: float):
	
	parent.handle_movement()

	parent.velocity.y += parent.gravity * delta
	if parent.is_on_floor():
		transition_to("idle")
	elif parent.is_on_wall():
		transition_to("wall_sliding")

func process_input(e: InputEvent):
	if e.is_action_pressed("jump"):
		parent.perform_jump()
		transition_to("rising")

	if e.is_action_pressed("dash"):
		parent.perform_dash()
