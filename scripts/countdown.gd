extends Label

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var time_left: int = 3


func _on_timer_timeout() -> void:
	anim.play("shake")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	time_left -= 1
	text = str(time_left)
	
	if time_left <= 0:
		Signals.game_started.emit()
		queue_free()
