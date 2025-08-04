extends CharacterBody2D

@onready var spr: AnimatedSprite2D = $AnimatedSprite
@onready var anim: AnimationPlayer = $AnimationPlayer

const GRAVITY: float = 98
const JFORCE: float = 1500
const HSPEED: float = 750
const ACCEL: float = 20.0
const DECCEL: float = 10.0

var was_on_floor: bool = false
var is_active: bool = false
var direction: int = 0


func _process(delta: float) -> void:
	if is_active:
		velocity.y += GRAVITY
		
		#Horizontal Movement
		
		if Input.is_action_pressed("move_right"):
			direction = 1
		elif Input.is_action_pressed("move_left"):
			direction = -1
		else:
			direction = 0
		
		if direction != 0:
			velocity.x = lerpf(velocity.x, direction * HSPEED, ACCEL * delta)
		else:
			velocity.x = lerpf(velocity.x, direction * HSPEED, DECCEL * delta)
		
		#Flip
		if velocity.x != 0:
			spr.flip_h = velocity.x > 0
		
		#Vertical Movement
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = -JFORCE
			
			anim.stop(true)
			anim.play("jump")
		
		move_and_slide()
		
		if not was_on_floor and is_on_floor():
			anim.stop(true)
			anim.play("grounded")
		
		was_on_floor = is_on_floor()


func _on_hit_box_area_entered(area: Area2D) -> void:
	pass
	#queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "appear":
		is_active = true
