class_name ThrowGrenades extends Attack

@export var grenade: PackedScene

var blocked: bool = false

var ammount: int
var delay: float = 0.5
var current_time: float = 0
var i: int

func enter() -> void:
	ammount = randi_range(1, 3)
	i = 0

func update(delta: float) -> void:
	current_time += delta
	
	if current_time > delay:
		get_tree().current_scene.add_child(grenade.instantiate())
		current_time = 0
		i += 1
		if i > ammount:
			finished.emit()
