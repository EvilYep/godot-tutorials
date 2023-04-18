@icon("res://Assets/HitBox.svg")
class_name HitBox
extends Area2D

@export var damage := 5

func get_damage() -> int:
	return damage + randi() % 7 - 3
