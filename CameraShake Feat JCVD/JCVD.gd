extends Node2D

enum {
	STATIC,
	WALK,
	RUN
}

@onready var jc_area: StaticBody2D = $JCArea
@onready var jcvd: AnimatedSprite2D = $JCArea/JCVD
@onready var shell: RigidBody2D = $Shell
@onready var cow: RigidBody2D = $Cow
@onready var crate: RigidBody2D = $Crate

@onready var gpu_particles_2d: GPUParticles2D = $JCArea/JCVD/GPUParticles2D
@onready var camera_2d: Camera2D = $JCArea/Camera2D
@onready var music: AudioStreamPlayer = $SFX/Music
@onready var hit_sound: AudioStreamPlayer = $SFX/HitSound
@onready var wilhelm_scream: AudioStreamPlayer = $SFX/WilhelmScream
@onready var game_over: AudioStreamPlayer = $SFX/GameOver
@onready var collision_shape: CollisionShape2D = $JCArea/CollisionShape2D2

var state: int = STATIC:
	set(st):
		match st:
			STATIC:
				velocity = Vector2.ZERO
				speed = 0.0
			WALK:
				velocity = Vector2(((-2 * int(jcvd.flip_h)) + 1), 0)
				speed = 17.0
			RUN:
				velocity = Vector2(((-2 * int(jcvd.flip_h)) + 1), 0)
				speed = 35.0

var velocity := Vector2.ZERO
var speed: float = 0.0

func _ready() -> void:
	randomize()
	_launch_anim()

func _physics_process(delta: float) -> void:
	#var sc = sin(Time.get_ticks_msec() * _delta * 0.20) / 5.0
	
	jc_area.position += velocity * speed * delta
	if cow.freeze:
		cow.position = jc_area.position + Vector2(-872, -312)

func _launch_anim() -> void:
	# Let's just say this mess is an attempt at a cutscene, I mainly wanted to do a screenshake and some other effects
	music.play()
	jcvd.play("idle")
	await get_tree().create_timer(2).timeout
	
	throw_shell()
	jcvd.play("kick")
	await get_tree().create_timer(1.0 / 13.0 * 5.0).timeout
	collision_shape.disabled = false
	await jcvd.animation_finished
	collision_shape.disabled = true
	jcvd.play("idle")
	await get_tree().create_timer(1).timeout
	
	throw_crate()
	jcvd.play("uppercut")
	await get_tree().create_timer(1.0 / 13.0 * 9.0).timeout
	collision_shape.disabled = false
	await jcvd.animation_finished
	jcvd.play("idle")
	await get_tree().create_timer(1).timeout
	
	jcvd.play("walk")
	state = WALK
	await get_tree().create_timer(1.2).timeout
	
	jcvd.play("run")
	state = RUN
	await get_tree().create_timer(1.2).timeout
	
	jcvd.play("turn")
	await get_tree().create_timer(0.2).timeout
	state = WALK
	await get_tree().create_timer(0.2).timeout
	state = STATIC
	await get_tree().create_timer(0.8).timeout
	velocity = Vector2.LEFT
	speed = 17.0
	await jcvd.animation_finished
	jcvd.flip_h = true
	
	throw_cow()
	jcvd.play("run")
	state = RUN

func throw_cow() -> void:
	cow.freeze = false
	cow.angular_velocity = -PI * 4
	cow.apply_impulse(Vector2(1000, -200))

func throw_shell() -> void:
	await get_tree().create_timer(0.05).timeout
	shell.freeze = false
	shell.angular_velocity = PI * 4
	shell.apply_impulse(Vector2(-1000, -200))

func throw_crate() -> void:
	await get_tree().create_timer(1.0 / 13.0 * 5.0).timeout
	crate.freeze = false
	crate.apply_impulse(Vector2(-10, 0))

func _on_cow_body_entered(_body: Node) -> void:
	music.stop()
	gpu_particles_2d.emitting = true
	camera_2d.start(.5, 0.015, 500)
	$Cow/AnimatedSprite2D.play("startle")
	state = STATIC
	jcvd.play("die")
	hit_sound.pitch_scale = randf_range(0.8, 1.2)
	hit_sound.play()
	wilhelm_scream.play()
	game_over.play()
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(jcvd, "offset", Vector2(0, 20), 0.7)


func _on_crate_body_entered(_body: Node) -> void:
	camera_2d.start(.25, 0.02, 350)
	$Crate/AnimatedSprite2D.play("explode")
	hit_sound.pitch_scale = randf_range(0.8, 1.2)
	hit_sound.play()


func _on_shell_body_entered(_body: Node) -> void:
	camera_2d.start(.25, 0.02, 350)
	hit_sound.pitch_scale = randf_range(0.8, 1.2)
	hit_sound.play()
