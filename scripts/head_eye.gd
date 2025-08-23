extends Sprite2D


var curr_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	Signals.barber_appeared.connect(appear)

func _process(delta: float) -> void:
	curr_pos = global_position

func appear() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 1.5)
	tween.tween_callback(func() -> void: Signals.third_eye_enabled.emit())
