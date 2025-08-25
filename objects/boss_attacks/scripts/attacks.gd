class_name Attacks extends Node


@export var initial_attack: Attack

@onready var origin_points: Array[Sprite2D] = [ %HeadEye, %LeftHand, %RightHand ]
@onready var delay: Timer = $Delay

var current_attack: Attack
var attacks: Dictionary


func _ready() -> void:
	randomize()
	if not System.disable_init_animation:
		Signals.game_started.connect(start_machine)
	else:
		await get_tree().create_timer(0.25).timeout
		start_machine()


func start_machine() -> void:
	for attack in get_children():
		if attack is Attack:
			attacks[attack.name.to_lower()] = attack
			attack.finished.connect(_on_attack_finished)
	
	if initial_attack:
		initial_attack.enter()
		current_attack = initial_attack
	

func _process(delta: float) -> void:
	if current_attack:
		current_attack.update(delta)


func get_random_point() -> Vector2:
	return origin_points[randi() % len(origin_points)].curr_pos


func _on_attack_finished() -> void:
	delay.start(randf_range(0.75, 2))
	if current_attack:
		current_attack.exit()
		current_attack = null


func _on_delay_timeout() -> void:
	var new_attack: Attack = attacks.get(attacks.keys().pick_random())
	
	if not new_attack:
		return
	
	
	new_attack.enter()
	current_attack = new_attack
