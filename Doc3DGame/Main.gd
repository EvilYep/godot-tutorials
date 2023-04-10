extends Node

@export var mob_scene: PackedScene = preload("res://Scenes/Mob.tscn")

@onready var player: CharacterBody3D = $Player
@onready var spawn_location: PathFollow3D = $SpawnPath/SpawnLocation
@onready var mob_timer: Timer = $MobTimer
@onready var score_label: Label = $UI/ScoreLabel
@onready var retry: ColorRect = $UI/Retry

func _ready() -> void:
	retry.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and retry.visible:
		get_tree().reload_current_scene()

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	# Choose a random location on the SpawnPath
	spawn_location.progress_ratio = randf()
	
	var player_position = player.position
	mob.initialize(spawn_location.position, player_position)
	
	add_child(mob)
	mob.squashed.connect(score_label.on_Mob_squashed.bind())

func _on_player_hit() -> void:
	mob_timer.stop()
	retry.show()
