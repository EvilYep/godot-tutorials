extends CharacterBody3D

@export var speed: int = 14 # m per s
@export var fall_acceleration: int = 75 # m per s^2
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
	
	# Actual move
	velocity = target_velocity
	move_and_slide()
