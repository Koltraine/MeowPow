class_name DashingState extends State

const DASH_FORGIVENESS: float = 0.5

var tween: Tween

func enter():
	parent.modulate.a = .2
	parent.hurt_box.monitorable = false
	parent.set_collision_layer_value(1, false)
	parent.set_collision_mask_value(2, false)

	if tween and tween.is_valid():
		tween.kill()
	
func exit():
	parent.modulate.a = 1
	
	tween = parent.create_tween()

	tween.tween_callback(func():
		parent.hurt_box.monitorable = true
		parent.set_collision_layer_value(1, true)
		parent.set_collision_mask_value(2, true)
	).set_delay(DASH_FORGIVENESS)

func process(_delta: float):
	pass

func process_input(_e: InputEvent):
	pass
