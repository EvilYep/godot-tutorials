extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_particles: GPUParticles2D = $HitParticles
@onready var damage_spawning_point: Marker2D = $DamageSpawningPoint

func _physics_process(delta: float) -> void:
	velocity = lerp(velocity, Vector2.ZERO, delta * 10)
	move_and_slide()

func take_damage(_damage: int) -> void:
	animation_player.play("hit")

func knock_back(from: Vector2) -> void:
	velocity = from.direction_to(global_position) * 300
