extends Node2D

@onready var screen_size: Vector2 = get_viewport_rect().end

var main_camera: Camera2D = null
var player: CharacterBody2D = null
var limit: Vector2 = Vector2.ZERO
var h_limit: int = 120

var disable_init_animation: bool = false
