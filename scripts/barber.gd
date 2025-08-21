extends Sprite2D

func _ready() -> void:
	Signals.zoom_finished.connect(appear)


func appear() -> void:
	System.main_camera.apply_shake(1, false)
	var tween: Tween = create_tween()
	tween.tween_property(self, "offset:y", -15, 5).set_delay(0.5)
	
	tween.tween_callback(barber_fully_entered)

func barber_fully_entered() -> void:
	Signals.barber_appeared.emit()
	System.main_camera.stop()
