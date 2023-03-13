extends KinematicBody2D

onready var progress_bar: ProgressBar = $HealthBar/ProgressBar

var __
var speed  := 20
var velocity := Vector2.ZERO
var hp := 200

var player : Node = null

#### BUILT-IN ####

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if self.visible:
		if player:
			velocity = position.direction_to(player.position) * speed
	__ = move_and_slide(velocity)

#### LOGIC ####

func handle_hit(damage: int) -> void:
	hp -= damage
	progress_bar.value = hp / 2
	if hp <= 0:
		queue_free()

#### SIGNAL RESPONSES ####

func _on_DetectionArea_body_entered(body: Node) -> void:
	player = body

func _on_DetectionArea_body_exited(_body: Node) -> void:
	player = null
	velocity = Vector2.ZERO

func _on_Timer_timeout() -> void:
	$DetectionArea/CollisionShape2D.set_deferred("disabled", false)

func _on_Area2D_body_entered(body: Node) -> void:
	self.visible = true
