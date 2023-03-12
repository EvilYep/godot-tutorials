extends KinematicBody2D

class_name Player

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

const ACCELERATION := 25
const RUN_SPEED := 80
const WALK_SPEED := 50
const FRICTION := RUN_SPEED

var __
var velocity := Vector2()
var input := Vector2()
var is_running : bool
var max_speed := WALK_SPEED

#### ACCESSORS ####

func is_class(value: String): return value == "Player" or .is_class(value)
func get_class() -> String: return "Player"

#### BUILT-IN ####

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if !input.is_equal_approx(Vector2.ZERO):
		velocity += input * ACCELERATION
		velocity = velocity.limit_length(max_speed)
		if is_running:
			animated_sprite.play("Run")
		else:
			 animated_sprite.play("Walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
		animated_sprite.play("Idle")
	
	__ = move_and_slide(velocity)

func _input(_event: InputEvent) -> void:
	input = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	animated_sprite.flip_h = input.x < 0
	
	is_running = Input.is_action_pressed("run")
	#if Input.is_action_pressed("run") : is_running = true
	#if Input.is_action_just_released("run") :is_running = false
	max_speed = RUN_SPEED if is_running else WALK_SPEED
	
#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
