extends Sprite2D

@export var target_pos: Marker2D
@onready var eye: Sprite2D = $Eye


const SPEED: float = 1
const FREQUENCY: float = 2
const AMPLITUDE: float = 15

var time: float = 0
var enabled: bool = false

var mode: int = 0
var delay: float = randf_range(3, 10)
var offset_pos: float = 0.0
var curr_pos: Vector2 = Vector2.ZERO


func _ready() -> void:
	mode = randi() % 2
	
	if not System.disable_init_animation:
		Signals.barber_appeared.connect(approach)
	else:
		curr_pos = eye.global_position
		global_position = target_pos.global_position
		enabled = true


func _process(delta: float) -> void:
	if enabled:
		curr_pos = eye.global_position
		if delay <= 0:
			if abs(offset_pos) > 0.01:
				offset_pos = lerpf(offset_pos, 0.0, 0.1)
			else:
				delay = randf_range(3, 10)
				mode = randi() % 2
				time = 0
		else:
			time += delta * SPEED
			delay -= delta
			offset_pos = AMPLITUDE * sin(time * FREQUENCY)
		match mode:
			0:
				global_position.y = target_pos.global_position.y + offset_pos
			1:
				global_position.x = target_pos.global_position.x + offset_pos
				


func approach() -> void:
	var tween: Tween = create_tween()
	
	tween.tween_property(self, "global_position", target_pos.global_position, 2)\
	.set_delay(1)\
	.set_ease(Tween.EASE_IN_OUT)\
	.set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func() -> void: enabled = true)
