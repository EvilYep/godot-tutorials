extends Node

@export var mob_scene: PackedScene = preload("res://Mob.tscn")
var score: int

@onready var player: Area2D = $Player
@onready var mob_timer: Timer = $MobTimer
@onready var score_timer: Timer = $ScoreTimer
@onready var start_timer: Timer = $StartTimer
@onready var start_position: Marker2D = $StartPosition

func _ready() -> void:
	new_game()

func game_over() -> void:
	score_timer.stop()
	mob_timer.stop()

func new_game() -> void:
	score = 0
	player.start(start_position.position)
	start_timer.start()

func _on_start_timer_timeout() -> void:
	score_timer.start()
	mob_timer.start()

func _on_score_timer_timeout() -> void:
	score += 1

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	
	mob.position = mob_spawn_location.position
	mob.rotation = direction
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
