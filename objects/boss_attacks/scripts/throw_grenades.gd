extends Node

@export var grenade: PackedScene

@onready var delay: Timer = $Delay

func execute() -> void:
	if delay.is_stopped():
		get_tree().current_scene.add_child(grenade.instantiate())
		delay.start()
		
