extends CanvasLayer

var new_scene : String

onready var animation_player: AnimationPlayer = $AnimationPlayer

func start_transition_to(path_to_scene: String) -> void:
	new_scene = path_to_scene
	animation_player.play("change_scene")

func change_scene() -> void:
	var __ = get_tree().change_scene(new_scene) == OK
	assert(__)
