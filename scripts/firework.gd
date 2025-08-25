class_name Firework extends Sprite2D


@onready var _explosion_scene: PackedScene = preload("res://objects/explosion.tscn")
@onready var _explosion_particles: PackedScene = preload("res://objects/particles/explosion_particles_2.tscn")


const _GRAVITY: float = 48
var _velocity: float = 0


func _ready() -> void:
	randomize()
	_velocity = -randf_range(1000, 1500)
	global_position = Vector2(randf_range(System.h_limit, System.screen_size.x - System.h_limit), System.screen_size.y)


func _process(delta: float) -> void:
	_velocity += _GRAVITY
	global_position.y += _velocity * delta


func _on_timer_timeout() -> void:
	var part: GPUParticles2D = _explosion_particles.instantiate()
	part.global_position = global_position
	get_tree().root.add_child(part)
	
	var inst: Node2D = _explosion_scene.instantiate()
	inst.global_position = global_position
	get_tree().root.add_child(inst)
	queue_free()
