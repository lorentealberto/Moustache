extends StaticBody2D

const SPEED: float = 125

var side: int = -1


func _process(delta: float) -> void:
	if side == -1:
		return
	
	match side:
		0:
			global_position.x += SPEED * delta
		1:
			global_position.x -= SPEED * delta

func set_side(_side: int) -> void:
	side = _side


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
