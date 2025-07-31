extends CharacterBody2D

@onready var spr: AnimatedSprite2D = $AnimatedSprite

const GRAVITY: float = 98
const JFORCE: float = 1500
const HSPEED: float = 750


#To-Do
# Comenzar animación una vez que el temporizador inicial haya terminado.
# Hacer zoom antes de la animación de aparición.
# La animación de aparición es una espiral.
# El juego no comenzará hasta que no haya acabado la animación de aparición.

func _process(delta: float) -> void:
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


func _on_hit_box_area_entered(area: Area2D) -> void:
	queue_free()
