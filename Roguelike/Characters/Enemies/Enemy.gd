extends Character
class_name Enemy, "res://Assets/goblin_icon.png"

var path : PoolVector2Array

onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

#### ACCESSORS ####

func is_class(value: String): return value == "Enemy" or .is_class(value)
func get_class() -> String: return "Enemy"

#### BUILT-IN ####

func _ready() -> void:
	pass

#### VIRTUALS ####

#### LOGIC ####

func chase() -> void:
	if path:
		var vector_to_next_point: Vector2 = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		if distance_to_next_point < 1:
			path.remove(0)
			if not path:
				return
		mov_direction = vector_to_next_point
		
		animated_sprite.flip_h = vector_to_next_point.x < 0

#### INPUTS ####

#### SIGNAL RESPONSES ####

func _on_PathTimer_timeout() -> void:
	path = Navigation2DServer.map_get_path(navigation_agent_2d.get_navigation_map(), global_position, player.position, false)
