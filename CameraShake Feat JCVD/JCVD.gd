extends Node2D

@onready var background: Sprite2D = $Marker2D/Background
@onready var cow: RigidBody2D = $Cow
@onready var jcvd: AnimatedSprite2D = $JCArea/JCVD
@onready var gpu_particles_2d: GPUParticles2D = $JCArea/JCVD/GPUParticles2D
@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	jcvd.play("idle")
	await get_tree().create_timer(1.2).timeout
	jcvd.play("kick")
	await jcvd.animation_finished
	jcvd.play("idle")
	await get_tree().create_timer(0.5).timeout
	jcvd.play("uppercut")
	await jcvd.animation_finished
	jcvd.play("idle")
	await get_tree().create_timer(0.5).timeout
	jcvd.play("walk")
	await get_tree().create_timer(1.2).timeout
	jcvd.play("run")
	await get_tree().create_timer(1.2).timeout
	jcvd.play("turn")
	await jcvd.animation_finished
	jcvd.flip_h = true
	throw_cow()
	jcvd.play("run")

func _physics_process(delta: float) -> void:
	background.rotation += delta * 0.05
	var sc = sin(Time.get_ticks_msec() * delta * 0.20) / 5.0
	background.scale = Vector2(1.5 + sc, 1.5 + sc)

func throw_cow() -> void:
	cow.freeze = false
	cow.angular_velocity = -PI * 4
	cow.apply_impulse(Vector2(1000, -200))


func _on_cow_body_entered(_body: Node) -> void:
	gpu_particles_2d.emitting = true
	camera_2d.start(.5, 0.05, 2000)
	$Cow/AnimatedSprite2D.play("startle")
	jcvd.play("die")

