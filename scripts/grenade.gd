extends Sprite2D

@onready var target_pos: Vector2 = Vector2(randf_range(System.h_limit, System.screen_size.x - System.h_limit), System.limit.y)

@export var explosion_scene: PackedScene
@export var explosion_particles_scene: PackedScene

var enabled: bool = true
var direction: int = 0

func _ready() -> void:
	randomize()
	global_position.x = randf_range(System.h_limit, System.screen_size.x - System.h_limit)
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_pos, randf_range(0.5, 2.0))
	tween.tween_callback(explode)#.set_delay(randf_range(0.5, 1.0))
	
	if global_position.x < target_pos.x:
		direction = 1
	elif global_position.x > target_pos.x:
		direction = -1


func _process(delta: float) -> void:
	if enabled:
		rotation_degrees += direction


func explode() -> void:
	enabled = false
	System.main_camera.apply_shake(1)
	
	var part: GPUParticles2D = explosion_particles_scene.instantiate()
	part.global_position = global_position
	get_tree().current_scene.add_child(part)
	
	var inst: Node2D = explosion_scene.instantiate()
	inst.global_position = global_position
	get_tree().current_scene.add_child(inst)
	queue_free()
