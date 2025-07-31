extends Node2D

@export var player_inst: PackedScene
@export var player_spawn: Marker2D

var game_started: bool = false


func _ready() -> void:
	Signals.game_started.connect(spawn_player)


func spawn_player() -> void:
	game_started = true
	var player: CharacterBody2D = player_inst.instantiate()
	player.global_position = player_spawn.global_position
	add_child(player)
