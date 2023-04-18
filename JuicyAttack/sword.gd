extends Node2D

var mouse_pos: Vector2

@onready var pivot: Marker2D = $Pivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shadow: Sprite2D = $Shadow

func attack() -> void:
	animation_player.play("slash")

func _physics_process(_delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	
	pivot.look_at(mouse_pos)
	
	pivot.scale.y =  -1 if mouse_pos.x - global_position.x < 0 else 1

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attack()
