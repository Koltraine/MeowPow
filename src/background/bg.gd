extends Sprite2D

const CLOUD_SPEED = 1.5

func _process(delta):
	material.get_shader_parameter("noiseClouds").noise.offset.x += CLOUD_SPEED * delta
