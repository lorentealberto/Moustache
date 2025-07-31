extends Camera2D

func _ready() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "zoom", Vector2(2, 2), 4).set_delay(1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)	
	tween.tween_property(self, "zoom", Vector2(1, 1), 0.1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)	
