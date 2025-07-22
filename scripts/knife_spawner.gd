extends Marker2D

@export var knife_scene: PackedScene

@onready var timer = $Timer
@onready var warning = $WarningIcon

func toggle():
	timer.start()

func _on_timer_timeout():
	warning.visible = true
	await get_tree().create_timer(1).timeout
	warning.visible = false
	
	var direction = -1
	
	if global_position.x < 1280 / 2:
		direction = 0
	else:
		direction = 1
		
	var instance = knife_scene.instantiate()
	instance.global_position = global_position
	instance.direction = direction
	get_parent().add_child(instance)
