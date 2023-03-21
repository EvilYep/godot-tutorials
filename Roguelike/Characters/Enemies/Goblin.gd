extends Enemy
class_name Goblin

const THROWABLE_KNIFE_SCENE := preload("res://Characters/Enemies/ThrowableKnife.tscn")

const MAX_DISTANCE_TO_PLAYER := 80
const MIN_DISTANCE_TO_PLAYER := 40

export(int) var projectile_speed := 150

onready var attack_timer: Timer = $AttackTimer
onready var aim_raycast: RayCast2D = $AimRayCast

var distance_to_player : float
var can_attack := true

#### LOGIC ####

func _get_path_to_move_away_from_player() -> void:
	var dir := (global_position - player.position).normalized()
	path = navigation.get_simple_path(global_position, global_position + dir * 100)

func _throw_knife() -> void:
	var projectile: Area2D = THROWABLE_KNIFE_SCENE.instance()
	projectile.throw(global_position, (player.position - global_position).normalized(), projectile_speed)
	get_tree().current_scene.add_child(projectile)

#### SIGNAL RESPONSES ####

func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		distance_to_player = (player.position - global_position).length()
		if distance_to_player > MAX_DISTANCE_TO_PLAYER:
			_get_path_to_player()
		elif distance_to_player < MIN_DISTANCE_TO_PLAYER:
			_get_path_to_move_away_from_player()
		else: 
			aim_raycast.cast_to = player.position - global_position
			if can_attack and state_machine.state == state_machine.states.idle and not aim_raycast.is_colliding():
				can_attack = false
				_throw_knife()
				attack_timer.start()
	else:
		path_timer.stop()
		path = []
		mov_direction = Vector2.ZERO

func _on_AttackTimer_timeout() -> void:
	can_attack = true
