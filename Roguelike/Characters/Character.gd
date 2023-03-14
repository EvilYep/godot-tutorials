extends KinematicBody2D
class_name Character, "res://Assets/knight_icon.png"

const FRICTION := 0.15

export(int) var acceleration := 40
export(int) var max_speed := 100

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

var mov_direction := Vector2.ZERO
var velocity := Vector2.ZERO 

#### ACCESSORS ####

func is_class(value: String): return value == "Character" or .is_class(value)
func get_class() -> String: return "Character"

#### BUILT-IN ####

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

#### LOGIC ####

func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * acceleration
	velocity = velocity.limit_length(max_speed)
