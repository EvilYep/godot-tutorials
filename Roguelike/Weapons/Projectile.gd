extends Hitbox

var enemy_exited := false

var direction := Vector2.ZERO
var knife_speed := 0

func throw(initial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = initial_position
	direction = dir
	knockback_direction = dir
	knife_speed = speed
	
	rotation += dir.angle() + PI/4

func _physics_process(delta: float) -> void:
	position += direction * knife_speed * delta

func _collide(body: KinematicBody2D) -> void:
	if enemy_exited:
		if body != null:
			body.take_damage(damage, knockback_direction, knockback_force)
		queue_free()

#### SIGNAL RESPONSES ####

func _on_ThrowableKnife_body_exited(_body: KinematicBody2D) -> void:
	if not enemy_exited:
		enemy_exited = true
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, true)
		set_collision_mask_bit(2, true)
		set_collision_mask_bit(3, true)
