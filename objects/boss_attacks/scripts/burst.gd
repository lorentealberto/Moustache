class_name Burst extends Attack


@onready var bullet_scene: PackedScene = preload("res://objects/bullet.tscn")


const _GAP: float = 10
const _DELAY: float = 0.1

var _head: Vector2 = Vector2.ZERO
var _angle: float = 0
var _total: int = 0
var _i: int = 0
var _t: float = 0


func enter() -> void:
	randomize()
	_head = sm.get_random_point()
	_i = 0
	_t = 0
	_angle = 0
	_total = randi_range(3, 6)


func update(delta: float) -> void:
	_t += delta
	if _t > _DELAY:
		_angle = rad_to_deg(_head.angle_to_point(System.player.global_position))
		
		var _inst: Bullet = bullet_scene.instantiate()
		_inst.global_position = _head
		_inst.direction = Vector2.RIGHT.rotated(deg_to_rad(_angle + (_i - 1) * _GAP))
		get_tree().current_scene.add_child(_inst)
		
		_t = 0
		_i += 1
		
		if _i >= _total:
			finished.emit()
