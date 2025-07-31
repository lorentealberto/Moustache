extends Area2D


@onready var spr: AnimatedSprite2D = $AnimatedSprite2D

const HSPEED: float = 150

var direction: int = -1

func _process(delta: float) -> void:
	if direction == -1:
		return
	
	match direction:
		0:
			global_position.x += HSPEED * delta
		1:
			global_position.x -= HSPEED * delta

func set_direction(_dir: int) -> void:
	direction = _dir
	spr.flip_h = _dir != 0
