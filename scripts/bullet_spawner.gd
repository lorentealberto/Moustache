extends Marker2D

enum Mode {BURST = 0, SPIRAL = 1, PULSE = 2}
enum Direction {CLOCKWISE = 1, COUNTER_CLOCKWISE = -1}

@export var mode: Mode
@export var direction: Direction = Direction.CLOCKWISE
@export var duration: float = 1.0
@export var patterns_pool: Array[BulletsPattern]
@export var bullet_scene: PackedScene
@export_category("Spread")
@export var spread_dispersion: int = 40

@onready var shoot_timer: Timer = $ShootTimer
@onready var duration_timer: Timer = $Duration

var steps: float = 0.0
var selected_pattern: BulletsPattern


func _ready() -> void:
	config_pattern()


func config_pattern() -> void:
	selected_pattern = patterns_pool[mode]
	duration_timer.one_shot = selected_pattern.one_shoot
	shoot_timer.start(selected_pattern.shoot_delay)
	steps = 360 / selected_pattern.spawn_point_count
	if not selected_pattern.one_shoot:
		duration_timer.start(duration)


func _on_duration_timeout() -> void:
	shoot_timer.stop()
	get_parent().queue_free()


func _on_shoot_timer_timeout() -> void:
	rotate(deg_to_rad(direction * selected_pattern.spiral_speed))
	
	var base_direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	var start_angle: float = deg_to_rad(-spread_dispersion / 2)
	var angle_increment: float = 0
	if selected_pattern.spawn_point_count > 1:
		angle_increment = deg_to_rad(spread_dispersion / (selected_pattern.spawn_point_count - 1))
		
	for s in selected_pattern.spawn_point_count:
		var current_angle: float = start_angle + s * angle_increment
		
		var bullet: Bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.direction = base_direction.rotated(current_angle)
		get_tree().root.add_child(bullet)
		
