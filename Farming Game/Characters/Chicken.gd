extends CharacterBody2D

var eating := false
var walking := false

var direction := Vector2.ZERO
var speed: int = 5

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var change_state_timer: Timer = $ChangeStateTimer
@onready var walking_timer: Timer = $WalkingTimer

func _ready() -> void:
	randomize()
	choose_direction()
	walking = true

func _physics_process(_delta: float) -> void:
	move_and_slide()

func choose_direction():
	direction = Vector2(randi_range(-1, 1), randi_range(-1, 1))

func _on_change_state_timer_timeout() -> void:
	change_state_timer.wait_time = randf_range(1.0, 5.0) if walking else randf_range(2.0, 6.0)
	eating = !eating
	walking = !walking
	if walking :
		animated_sprite.play("walking")
		choose_direction()
	else:
		animated_sprite.play("eating")
		direction = Vector2.ZERO
	velocity = direction * speed
	change_state_timer.start()

func _on_walking_timer_timeout() -> void:
	choose_direction()
	animated_sprite.flip_h = direction.x < 0
	walking_timer.wait_time = randf_range(1.0, 4.0)
	walking_timer.start()
