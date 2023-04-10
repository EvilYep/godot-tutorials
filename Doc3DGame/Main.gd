extends Node

@export var mob_scene: PackedScene = preload("res://Scenes/Mob.tscn")

@onready var player: CharacterBody3D = $Player
@onready var spawn_location: PathFollow3D = $SpawnPath/SpawnLocation

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	# Choose a random location on the SpawnPath
	spawn_location.progress_ratio = randf()
	
	var player_position = player.position
	mob.initialize(spawn_location.position, player_position)
	
	add_child(mob)
