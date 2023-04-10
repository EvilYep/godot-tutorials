extends CharacterBody3D

@export var speed: int = 14 # m per s
@export var fall_acceleration: int = 75 # m per s^2
@export var jump_impulse: int = 20
@export var bounce_impulse: int = 16
@onready var pivot: Node3D = $Pivot

var target_velocity := Vector3.ZERO


func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x +=1
	if Input.is_action_pressed("move_left"):
		direction.x -=1
	if Input.is_action_pressed("move_back"):
		direction.z +=1
	if Input.is_action_pressed("move_forward"):
		direction.z -=1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		pivot.look_at(position + direction, Vector3.UP)
	
	# Grounbd velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Vertical velocity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	# Jumping
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	
	# Killing enemies by jumping on them
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		
		# if collision with ground
		if (collision.get_collider() == null):
			continue
		# if collision with mob
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			# we checked we collided with it from above
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				mob.squash() 
				target_velocity.y = bounce_impulse
	
	# Actual move
	velocity = target_velocity
	move_and_slide()
