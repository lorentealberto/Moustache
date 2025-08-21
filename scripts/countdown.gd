extends Label

@export var particles: PackedScene
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var part_pos: Marker2D = $ParticlesPosition

var time_left: int = 3


func _on_timer_timeout() -> void:
	anim.play("shake")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade in":
			timer.start()
		_:
			time_left -= 1
			text = str(time_left)
			
			if time_left <= 0:
				timer.stop()
				
				var inst: GPUParticles2D = particles.instantiate()
				inst.global_position = part_pos.global_position
				get_tree().root.add_child(inst)
				Signals.game_started.emit()
				System.main_camera.apply_shake(0.5, true)
				get_parent().queue_free()
