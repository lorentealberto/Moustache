extends Marker2D

@export var platform_scene: PackedScene

@onready var timer: Timer = $Timer


func _ready() -> void:
	randomize()
	Signals.game_started.connect(start_game)

func start_game() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	var instance: StaticBody2D = platform_scene.instantiate()
	
	instance.global_position = global_position
	
	instance.set_side(0 if global_position.x < 1280 / 2 else 1)

	get_parent().add_child(instance)
