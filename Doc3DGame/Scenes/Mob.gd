extends CharacterBody3D

signal squashed

@export var min_speed: int = 10 # m per s
@export var max_speed: int = 18


func _physics_process(_delta: float) -> void:
	move_and_slide()

func initialize(start_position: Vector3, player_position: Vector3) -> void:
	# position the mob at start_position then make it look at player
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	var random_speed = randi_range(min_speed, max_speed)
	# speed
	velocity = Vector3.FORWARD * random_speed
	# direction
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
	$AnimationPlayer.speed_scale = int(float(random_speed) / float(min_speed))

func _on_visibility_notifier_screen_exited() -> void:
	queue_free()

func squash() -> void:
	squashed.emit()
	queue_free()
