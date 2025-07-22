extends Node

@export var platform_scene: PackedScene

@onready var positions = [$Marker2D, $Marker2D3]

func _ready():
	randomize()

func spawn_platform():
	var rnd = randi() % 2
	print(rnd)
	
	var instance = platform_scene.instantiate()
	
	instance.global_position = positions[rnd].global_position
	
	if rnd == 0:
		instance.set_side(0)
	else:
		instance.set_side(1)

	add_child(instance)


func _on_timer_timeout():
	spawn_platform()
