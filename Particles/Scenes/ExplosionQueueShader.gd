extends "res://Scenes/ParticleQueue.gd"

#### ACCESSORS ####

#### BUILT-IN ####

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		var p : GPUParticles2D = get_next_particle()
		p.global_position = get_global_mouse_position()
		p.process_material.set_shader_parameter("bound", p.to_local(Vector2(0, 400)).y)
		trigger()

#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
