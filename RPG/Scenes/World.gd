extends Node2D

onready var player: KinematicBody2D = $Player

#### BUILT-IN ####

func _ready() -> void:
	randomize()
	if Global.door_name:
		var _door_node = find_node(Global.door_name)
		player.position.x = 327
		player.position.y = 70
