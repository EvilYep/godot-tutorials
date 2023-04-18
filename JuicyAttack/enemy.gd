extends CharacterBody2D

var damage_scene: PackedScene = preload("res://damage.tscn")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_particles: GPUParticles2D = $HitParticles
@onready var damage_spawning_point: Marker2D = $DamageSpawningPoint

func _physics_process(delta: float) -> void:
	velocity = lerp(velocity, Vector2.ZERO, delta * 10)
	move_and_slide()

func take_damage(damage: int) -> void:
	animation_player.play("hit")
	
	var damage_feedback: Node2D = damage_scene.instantiate()
	damage_feedback.global_position = damage_spawning_point.global_position
	damage_feedback.set_damage(damage)
	add_child(damage_feedback)
	
	Events.enemy_hit.emit()

func knock_back(from: Vector2) -> void:
	hit_particles.rotation = get_angle_to(from) + PI
	velocity = from.direction_to(global_position) * 300
