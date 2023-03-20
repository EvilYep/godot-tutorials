extends Character
class_name Enemy, "res://Assets/goblin_icon.png"

var path : PoolVector2Array
var target : Vector2

onready var navigation: Navigation2D = get_tree().current_scene.get_node("Rooms")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
onready var path_timer: Timer = $PathTimer

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
	if is_instance_valid(player):
		path = navigation.get_simple_path(global_position, player.position)
	else:
		path_timer.stop()
		path = []
		mov_direction = Vector2.ZERO
