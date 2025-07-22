extends Node

@onready var timer = $Timer
@onready var spawners = [$KnifeSpawner, $KnifeSpawner2, $KnifeSpawner3, $KnifeSpawner4]

func _ready():
	randomize()
	timer.start(randf_range(1.0, 2.5))

func _on_timer_timeout():
	spawners[randi() % 4].toggle()
	timer.start(randf_range(1.0, 2.5))
