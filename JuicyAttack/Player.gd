extends CharacterBody2D

const DRAG_FACTOR := 15.0
const SPEED := 600.0

@onready var sword: Node2D = $Sword

var direction: Vector2

func _physics_process(_delta: float) -> void:
	direction = Vector2(Input.get_axis("movfe_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	
	velocity = direction * SPEED
	move_and_slide()
