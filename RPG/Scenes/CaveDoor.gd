extends Area2D

export(String, FILE, "*.tscn,*,scn") var new_scene

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if get_overlapping_bodies().size() > 0:
			next_level()

func next_level() -> void:
	var _PTS = get_tree().change_scene(new_scene)
	Global.door_name = name
