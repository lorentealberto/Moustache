extends Area2D

const HSPEED = 200

var direction = -1

func _process(delta):
	if direction == -1:
		return
	
	match direction:
		0:
			global_position.x += HSPEED * delta
		1:
			global_position.x -= HSPEED * delta
