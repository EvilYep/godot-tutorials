extends Node2D

@export var slo_mo_time := 0.3
@export var slo_mo_value := 0.07

func _ready() -> void:
	Events.enemy_hit.connect(slow_motion)

func slow_motion() -> void:
	Engine.time_scale = slo_mo_value
	await get_tree().create_timer(slo_mo_time * slo_mo_value).timeout
	Engine.time_scale = 1
