extends Node

@export var platform_scene: PackedScene

@onready var positions: Array = [$Marker2D, $Marker2D3]

func _ready() -> void:
	randomize()
	Signals.game_started.connect(start_game)

func spawn_platform() -> void:
	var rnd: int = randi() % 2
	
	var instance: StaticBody2D = platform_scene.instantiate()
	
	instance.global_position = positions[rnd].global_position
	
	if rnd == 0:
		instance.set_side(0)
	else:
		instance.set_side(1)

	add_child(instance)


func start_game() -> void:
	print("Warro")
	


func _on_timer_timeout() -> void:
	spawn_platform()
