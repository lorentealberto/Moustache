class_name OscillatingBurst extends Attack

const _GAP: float = 10
const _DELAY: float = 0.1
const _FREQUENCY: float = 10
const _AMPLITUDE: float = 20

var _head: Vector2 = Vector2.ZERO
var _angle: float = 0
var _total: int = 0
var _i: int = 0
var _t: float = 0
var _wave_time: float = 0


func enter() -> void:
	randomize()
	_head = sm.get_random_point()
	_i = 0
	_t = 0
	_angle = 0
	_total = randi_range(25, 50)
	_wave_time = 0


func update(delta: float) -> void:
	_t += delta
	if _t > _DELAY:
		
		_angle = rad_to_deg(_head.angle_to_point(System.player.global_position))
		var _inst: Bullet = bullet_scene.instantiate()
		_inst.global_position = _head
		
		_wave_time += delta
		var offset: float = (_AMPLITUDE * sin(_i * _FREQUENCY))
		var n_angle: float = _angle + offset

		_inst.direction = Vector2.RIGHT.rotated(deg_to_rad(n_angle))
		get_tree().current_scene.add_child(_inst)
		
		_t = 0
		_i += 1
		
		if _i >= _total:
			finished.emit()
