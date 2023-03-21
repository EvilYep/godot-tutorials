extends Area2D
class_name Hitbox

export(int) var damage := 1
export(int) var knockback_force := 300
var knockback_direction := Vector2.ZERO
var body_inside := false

onready var collision_shape: CollisionShape2D = get_child(0)
onready var timer: Timer = Timer.new()

#### ACCESSORS ####

func is_class(value: String): return value == "Hitbox" or .is_class(value)
func get_class() -> String: return "Hitbox"

#### BUILT-IN ####

func _init() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")
	__ = connect("body_exited", self, "_on_body_exited")

func _ready() -> void:
	assert(collision_shape != null)
	timer.wait_time = 1
	add_child(timer)

#### LOGIC ####

func _collide(body: KinematicBody2D) -> void:
	if body == null or not body.has_method("take_damage"):
		queue_free()
	else:
		body.take_damage(damage, knockback_direction, knockback_force)

#### SIGNAL RESPONSES ####s

func _on_body_entered(body: PhysicsBody2D) -> void:
	body_inside = true
	timer.start()
	while body_inside:
		_collide(body)
		yield(timer, "timeout")

func _on_body_exited(_body: KinematicBody2D) -> void:
	body_inside = false
	timer.stop()
