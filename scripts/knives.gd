extends Node

@onready var timer: Timer = $Timer
@onready var spawners: Array = [$KnifeSpawner, $KnifeSpawner2, $KnifeSpawner3, $KnifeSpawner4]

func _ready() -> void:
	randomize()
	Signals.game_started.connect(start_game)
	

func _on_timer_timeout() -> void:
	spawners[randi() % 4].toggle()
	timer.start(randf_range(1.0, 2.5))


func start_game() -> void:
	timer.start(randf_range(1.0, 2.5))
