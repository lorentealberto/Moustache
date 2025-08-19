extends Node


@export var initial_attack: Attack

var current_attack: Attack
var attacks: Dictionary

func _ready() -> void:
	Signals.game_started.connect(start_machine)


func start_machine() -> void:
	for attack in get_children():
		if attack is Attack:
			attacks[attack.name.to_lower()] = attack
			attack.finished.connect(on_attack_finished)
	
	if initial_attack:
		initial_attack.enter()
		current_attack = initial_attack
	

func _process(delta: float) -> void:
	if current_attack:
		current_attack.update(delta)


func on_attack_finished() -> void:
	var new_attack: Attack = attacks.get(attacks.keys().pick_random())
	if not new_attack:
		return
	
	if current_attack:
		current_attack.exit()
	
	new_attack.enter()
	current_attack = new_attack
