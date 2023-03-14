extends Node
class_name StateMachine

var states: Dictionary = {}
var previous_state: int = -1
var state: int = -1 setget set_state

onready var parent: Character = get_parent()
onready var animation_player: AnimationPlayer = get_parent().get_node("AnimationPlayer")

#### ACCESSORS ####

func is_class(value: String): return value == "StateMachine" or .is_class(value)
func get_class() -> String: return "StateMachine"

func set_state(new_state: int) -> void:
	exit_state(state)
	previous_state = state
	state = new_state
	enter_state(state, previous_state)

#### BUILT-IN ####

func _physics_process(delta: float) -> void:
	if state != -1:
		update(delta)
		var transition = get_transition()
		if transition != -1:
			set_state(transition)

#### LOGIC ####

func add_state(state_name: String) -> void:
	states[state_name] = states.size()

#### VIRTUALS ####

func update(_delta: float) -> void:
	pass

func get_transition() -> int:
	return -1

func enter_state(_new_state: int, _old_state: int) -> void:
	pass

func exit_state(_state_exited: int) -> void:
	pass
