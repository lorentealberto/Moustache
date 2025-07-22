extends StaticBody2D

const SPEED = 200

var side = -1


func _process(delta):
	if side == -1:
		return
	
	match side:
		0:
			global_position.x += SPEED * delta
		1:
			global_position.x -= SPEED * delta

func set_side(_side):
	side = _side


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
