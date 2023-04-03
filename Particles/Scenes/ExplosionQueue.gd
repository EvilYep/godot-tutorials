extends "res://Scenes/ParticleQueue.gd"

#### ACCESSORS ####

#### BUILT-IN ####

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		get_next_particle().global_position = get_global_mouse_position()
		trigger()

#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
