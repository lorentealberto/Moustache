class_name Attack extends Node

signal finished

#Ref. Máquina de estados
@onready var sm: Node = get_parent()
@onready var bullet_scene: PackedScene = preload("res://objects/bullet.tscn")

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass
