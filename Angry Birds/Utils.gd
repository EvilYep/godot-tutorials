extends Node2D

var particle_scene: PackedScene = preload("res://Scenes/ScoreParticle.tscn")

func pop_score(pos: Vector2, score) -> void:
	var particle = particle_scene.instantiate()
	particle.setup(pos, str(score))
	get_tree().get_first_node_in_group("Game").add_child(particle)
	particle.particle.emitting = true
