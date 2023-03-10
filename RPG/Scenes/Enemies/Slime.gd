extends KinematicBody2D

var __
var speed  := 25
var velocity := Vector2.ZERO
var hp := 50

var player : Node = null

#### BUILT-IN ####

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if player:
		velocity = position.direction_to(player.position) * speed
	__ = move_and_slide(velocity)

#### LOGIC ####

func handle_hit(damage: int) -> void:
	hp -= damage
	if hp <= 0:
		queue_free()

#### SIGNAL RESPONSES ####

func _on_DetectionArea_body_entered(body: Node) -> void:
	player = body

func _on_DetectionArea_body_exited(_body: Node) -> void:
	player = null
	velocity = Vector2.ZERO
