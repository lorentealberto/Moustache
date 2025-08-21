extends Sprite2D

func _ready() -> void:
	Signals.barber_appeared.connect(appear)


func appear() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 1.5)
	tween.tween_callback(func() -> void: Signals.third_eye_enabled.emit())
