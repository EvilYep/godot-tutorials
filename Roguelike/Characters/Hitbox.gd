extends Area2D
class_name Hitbox

export(int) var damage := 1
export(int) var knockback_force := 300
var knockback_direction := Vector2.ZERO

onready var collision_shape: CollisionShape2D = get_child(0)

#### ACCESSORS ####

func is_class(value: String): return value == "Hitbox" or .is_class(value)
func get_class() -> String: return "Hitbox"

#### BUILT-IN ####

func _init() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")

func _ready() -> void:
	assert(collision_shape != null)

#### LOGIC ####

func _collide(body: KinematicBody2D) -> void:
	if body == null or not body.has_method("take_damage"):
		queue_free()
	else:
		body.take_damage(damage, knockback_direction, knockback_force)

#### SIGNAL RESPONSES ####s

func _on_body_entered(body: PhysicsBody2D) -> void:
	_collide(body)
