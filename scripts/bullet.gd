extends Sprite2D
class_name Bullet

@export var horizontal_speed: float = 100.0


func _process(delta: float) -> void:
	global_position += transform.x.normalized() * (horizontal_speed * delta)
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
