extends Node2D

@export var player_inst: PackedScene
@export var countdown_inst: PackedScene
@export var player_spawn: Marker2D
@export var countdown_position: Marker2D

@onready var limit: Marker2D = $Limit

var game_started: bool = false


@export var grenade_scene: PackedScene



func _ready() -> void:
	Signals.zoom_half.connect(spawn_player)
	Signals.third_eye_enabled.connect(spawn_countdown)
	
	System.limit = limit.global_position


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawn_grenade"):
		add_child(grenade_scene.instantiate())

func spawn_player() -> void:
	game_started = true
	var player: CharacterBody2D = player_inst.instantiate()
	player.global_position = player_spawn.global_position
	add_child(player)


func spawn_countdown() -> void:
	var inst: Node2D = countdown_inst.instantiate()
	inst.global_position = countdown_position.global_position
	add_child(inst)
