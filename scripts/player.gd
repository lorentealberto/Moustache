extends CharacterBody2D

@onready var spr = $AnimatedSprite

const GRAVITY = 98
const JFORCE = 1500
const HSPEED = 750

func _process(delta):
	velocity.y += GRAVITY
	
	#Horizontal Movement
	if Input.is_action_pressed("move_right"):
		velocity.x = HSPEED
	elif Input.is_action_pressed("move_left"):
		velocity.x = -HSPEED
	else:
		velocity.x = 0
	
	#Flip
	if velocity.x != 0:
		spr.flip_h = velocity.x > 0
	
	#Vertical Movement
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -JFORCE
	
	move_and_slide()


func _on_hit_box_area_entered(area):
	queue_free()
