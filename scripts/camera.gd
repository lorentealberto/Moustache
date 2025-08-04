extends Camera2D

func _ready() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "zoom", Vector2(2.5, 2.5), 2.5).set_delay(1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)	
	tween.tween_property(self, "zoom", Vector2(1, 1), 0.1).set_delay(0.75).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)	
	tween.tween_callback(zoom_is_ended)

func zoom_is_ended() -> void:
	Signals.zoom_ended.emit()
