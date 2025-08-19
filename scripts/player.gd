extends CharacterBody2D

@onready var spr: AnimatedSprite2D = $AnimatedSprite
@onready var anim: AnimationPlayer = $AnimationPlayer

const GRAVITY: float = 98
const JFORCE: float = 1500
const HSPEED: float = 750
const ACCEL: float = 20.0
const DECCEL: float = 10.0
const SPRING: float = 180
const DAMP: float = 7
const VELOCITY_MULTIPLIER: float = 0.25

var was_on_floor: bool = false
var is_active: bool = false
var direction: int = 0
var displacement: float = 0
var oscillator_velocity: float = 0


func _ready() -> void:
	System.player = self
	Signals.zoom_finished.connect(_enable_player)


func _process(delta: float) -> void:
	if is_active:
		velocity.y += GRAVITY
		
		#Horizontal Movement
		direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
		if direction != 0:
			velocity.x = lerpf(velocity.x, direction * HSPEED, ACCEL * delta)
		else:
			velocity.x = lerpf(velocity.x, direction * HSPEED, DECCEL * delta)
		
		#Oscillator
		oscillator_velocity += (velocity.x / HSPEED) * VELOCITY_MULTIPLIER
		var force: float = -SPRING * displacement + DAMP * oscillator_velocity
		oscillator_velocity -= force * delta
		displacement -= oscillator_velocity * delta
		spr.rotation = -displacement
		
		#Flip
		if velocity.x != 0:
			spr.flip_h = velocity.x > 0
		
		#Vertical Movement
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = -JFORCE
			anim.stop(true)
			anim.play("jump")
		
		move_and_slide()
		
		#Check when grounded
		if not was_on_floor and is_on_floor():
			anim.stop(true)
			anim.play("grounded")
			System.main_camera.apply_shake(0.25)
		
		was_on_floor = is_on_floor()


func _on_hit_box_area_entered(area: Area2D) -> void:
	pass
	#queue_free()

func _enable_player() -> void:
	is_active = true


func _on_appear_particles_finished() -> void:
	Signals.player_spawned.emit()
