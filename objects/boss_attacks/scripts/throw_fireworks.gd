class_name ThrowFireworks extends Attack

@onready var firework_scene: PackedScene = preload("res://objects/firework.tscn")
const _DELAY: float = 0.5

var _total: int = 0
var _i: int = 0
var _t: float = 0


func enter() -> void:
	_i = 0
	_t = 0
	_total = randi_range(1, 3)


func update(delta: float) -> void:
	_t += delta
	if _t > _DELAY:
		var inst: Firework = firework_scene.instantiate()
		get_tree().current_scene.add_child(inst)
		_t = 0
		_i += 1
		if _i >= _total:
			finished.emit()
