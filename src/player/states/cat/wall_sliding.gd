class_name WallSlidingState extends State

const WALL_SLIDE_SPEED: float = 50.0

func enter():
	animations.play("cat_fall")
	parent.reset_jumps()


func exit():
	pass


func process(delta: float):
	parent.velocity.y = min(parent.velocity.y + parent.gravity * delta, WALL_SLIDE_SPEED)
	
	var direction = Input.get_axis("left", "right")
	if direction == 0 or !parent.is_on_wall():
		transition_to("falling")
		return
    
	if parent.is_on_floor():
		if direction == 0:
			transition_to("idle")
		else:
			transition_to("walking")
		

	parent.velocity.x = direction * parent.SPEED


func process_input(e: InputEvent):

	if e.is_action_pressed("jump"):
		parent.perform_jump()
		
	if e.is_action_pressed("dash"):
		parent.perform_dash()
