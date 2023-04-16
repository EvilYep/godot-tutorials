extends CharacterBody2D

signal direction_changed(direction)

const SPEED = 150.0

var direction := Vector2.ZERO:
	set(dir):
		if direction != dir:
			direction = dir
			direction_changed.emit(direction)

@onready var sprite: Sprite2D = $Sprite
@onready var animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	animation_tree.get("parameters/playback").travel("Idle")
	direction_changed.connect(_on_direction_changed)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _input(_event: InputEvent) -> void:
	direction = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	).normalized()
	sprite.flip_h = direction.x > 0
	
	velocity = direction * SPEED

func _on_direction_changed(dir: Vector2) -> void:
	animation_tree.set("parameters/Idle/blend_position", dir)
	animation_tree.set("parameters/Walk/blend_position", dir)
	
	if dir.is_equal_approx(Vector2.ZERO):
		animation_tree.get("parameters/playback").travel("Idle")
	else:
		animation_tree.get("parameters/playback").travel("Walk")
