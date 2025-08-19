extends Sprite2D
class_name Bullet


@export var horizontal_speed: float = 75.0

var direction: Vector2 = Vector2.RIGHT

func _process(delta: float) -> void:
	global_position += direction * (horizontal_speed * delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
