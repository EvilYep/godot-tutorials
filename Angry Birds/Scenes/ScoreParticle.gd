extends Node2D

@onready var viewport: SubViewport = $SubViewport
@onready var points: Label = $SubViewport/Points
@onready var particle: GPUParticles2D = $Particle
@onready var despawn_timer: Timer = $DespawnTimer

func _ready() -> void:
	particle.texture = viewport.get_texture()
	despawn_timer.wait_time = particle.lifetime * particle.speed_scale
	despawn_timer.start()

func setup(pos: Vector2, score: String) -> void:
	global_position = pos
	$SubViewport/Points.text = str(int(score))

func _on_despawn_timer_timeout() -> void:
	queue_free()
