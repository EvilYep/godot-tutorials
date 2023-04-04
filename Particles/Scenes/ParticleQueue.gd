extends Node2D

@export var particle : PackedScene
@export var queue_count: int = 8

var index : int = 0 

#### ACCESSORS ####

#### BUILT-IN ####

func _ready():
	for i in range(queue_count):
		add_child(particle.instantiate())

#### VIRTUALS ####

#### LOGIC ####

func get_next_particle() -> GPUParticles2D:
	return get_child(index)

func trigger() -> void:
	get_next_particle().restart()
	index = (index + 1) % queue_count

#### INPUTS ####

#### SIGNAL RESPONSES ####
