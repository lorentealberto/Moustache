extends Marker2D

@export var bullet_scene: PackedScene

@onready var timer: Timer = $Timer

enum Direction {CLOCKWISE = 1, COUNTER_CLOCKWISE = -1}

@export_category("Configuration")
@export var spawn_point_count: int = 1
@export_range(0, 20) var spiral_speed: int
@export var shoot_delay: float = 0.1
@export var direction: Direction = Direction.CLOCKWISE

var steps: int = 0


func _ready() -> void:
	steps = 360 / spawn_point_count
	timer.start(shoot_delay)

func _on_timer_timeout() -> void:
	rotate(deg_to_rad(direction * spiral_speed))
	for s in spawn_point_count:
		var bullet: Bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.rotation = rotation
		get_tree().root.add_child(bullet)
		rotate(deg_to_rad(steps))
