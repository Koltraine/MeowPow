class_name JumpingState extends State

func link_sm(sm: SM) -> void:
	super.link_sm(sm)
	animations.connect("animation_finished", _on_animation_finished)


func enter():
	if not parent.is_on_floor() and parent.stamina < 1:
		transition_to("rising" if parent.velocity.y < 0 else "falling")
		return
	
	parent.stamina -= 0 if parent.is_on_floor() else 1
	parent.velocity.y = parent.JUMP_VELOCITY
	animations.play("cat_jump")

	
func exit():
	pass

func process(delta: float):
	parent.handle_movement()
	parent.velocity.y += parent.gravity * delta


func _on_animation_finished():
	transition_to("rising")

func process_input(e: InputEvent):
	if e.is_action_pressed("jump"):
		transition_to("jumping")
