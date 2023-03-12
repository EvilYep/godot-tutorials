extends KinematicBody2D

onready var timer: Timer = $Timer
onready var animated_sprite: AnimatedSprite = $AnimatedSprite

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

const SPEED := 30

var current_state := IDLE
var dir = Vector2.ZERO

var start_pos : Vector2

#### BUILT-IN ####

func _physics_process(delta: float) -> void:
	match current_state:
		IDLE:
			animated_sprite.play("Idle")
		NEW_DIR:
			dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
		MOVE:
			animated_sprite.play("Walk")
			move(delta)

func _ready() -> void:
	start_pos = position

#### LOGIC ####

func move(delta) -> void:
	position += dir * SPEED * delta
	if position.x >= start_pos.x + 20:
		position.x = start_pos.x + 19.9
	elif position.x <= start_pos.x - 20:
		position.x = start_pos.x - 19.9
	if position.y >= start_pos.y + 20:
		position.y = start_pos.y + 19.9
	elif position.y <= start_pos.y - 20:
		position.y = start_pos.y - 19.9
	animated_sprite.flip_h = dir.x < 0

func choose(array : Array):
	array.shuffle()
	return array.front()

#### INPUTS ####

#### SIGNAL RESPONSES ####

func _on_Timer_timeout() -> void:
	timer.wait_time = choose([0.5, 1.0, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
	timer.start()
