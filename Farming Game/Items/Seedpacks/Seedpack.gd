class_name Seedpack
extends StaticBody2D

@export var seed_type: Global.Plants
@export var growth_speed: int
var selected = false

func _ready() -> void:
	$AnimatedSprite.play("default")

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			Global.selected_plant = -1

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		Global.selected_plant = seed_type
		selected = true
