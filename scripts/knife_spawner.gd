extends Marker2D

@export var knife_scene: PackedScene

@onready var timer: Timer = $Timer
@onready var warning: Sprite2D = $WarningIcon

func toggle() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	warning.visible = true
	await get_tree().create_timer(1).timeout
	warning.visible = false
	
	var direction: int = -1
	
	if global_position.x < 1280 / 2:
		direction = 0
	else:
		direction = 1
		
	var instance: Area2D = knife_scene.instantiate()
	instance.global_position = global_position
	get_parent().add_child(instance)
	instance.set_direction(direction)
