extends Camera2D


@export var noise: FastNoiseLite

var x_noise_sample: Vector2 = Vector2.RIGHT
var y_noise_sample: Vector2 = Vector2.DOWN

var noise_sample_travel_rate: float = 500

var max_shake: int = 16
var current_percentage: float = 0
var x_noise_sample_position: Vector2 = Vector2.ZERO
var y_noise_sample_position: Vector2 = Vector2.ZERO
var decay: float = 2
var autostop: bool = true


func _ready() -> void:
	Signals.player_spawned.connect(zoom_out)
	
	if not System.disable_init_animation:
		var tween: Tween = create_tween()
		tween.tween_property(self, "zoom", Vector2(2.5, 2.5), 1.5).set_delay(1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)	
		tween.tween_callback(zoom_half)
	
	System.main_camera = self


func _process(delta: float) -> void:
	if current_percentage > 0:
		x_noise_sample_position += x_noise_sample * noise_sample_travel_rate * delta
		y_noise_sample_position += y_noise_sample * noise_sample_travel_rate * delta
		
		var x_sample: float = noise.get_noise_2d(x_noise_sample_position.x, x_noise_sample_position.y)
		var y_sample: float = noise.get_noise_2d(y_noise_sample_position.x, y_noise_sample_position.y)
		
		var calculated_offset: Vector2 = Vector2(x_sample, y_sample) * max_shake * current_percentage
		offset = calculated_offset
		
		var ndecay: float = decay
		if not autostop: ndecay = 0
		
		current_percentage = clamp(current_percentage - ndecay * delta, 0, 1)


func zoom_half() -> void:
	Signals.zoom_half.emit()


func zoom_out() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "zoom", Vector2(1, 1), 0.1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(Signals.zoom_finished.emit)


func apply_shake(percentage: float, _autostop: bool) -> void:
	if autostop:
		current_percentage = clamp(percentage, 0, 1)
		autostop = _autostop


func stop() -> void:
	autostop = true
