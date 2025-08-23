class_name ThrowGrenades extends Attack

@export var grenade: PackedScene

var blocked: bool = false

var ammount: int
var delay: float = 0.5
var current_time: float = 0
var i: int
var orig: Vector2

func enter() -> void:
	orig = attacks.origin_points[randi() % len(attacks.origin_points)].curr_pos
	ammount = randi_range(1, 3)
	i = 0

func update(delta: float) -> void:
	current_time += delta
	if current_time > delay:
		var inst: Sprite2D = grenade.instantiate()
		inst.global_position = orig
		get_tree().current_scene.add_child(inst)
		current_time = 0
		i += 1
		if i > ammount:
			finished.emit()
