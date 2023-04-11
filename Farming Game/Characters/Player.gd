extends CharacterBody2D


var speed: int = 50
var direction := Vector2.ZERO

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta: float) -> void:
	direction = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	).normalized()
	
	if abs(direction.x) > abs(direction.y):
		animated_sprite.play("side_walk")
		animated_sprite.flip_h = direction.x > 0
	elif direction.y > 0:
		animated_sprite.play("walk_down")
	elif direction.y < 0:
		animated_sprite.play("walk_up")
	else:
		animated_sprite.play("idle") 
	
	velocity = direction * speed
	
	move_and_slide()
