@tool
extends Sprite2D

func _ready() -> void:
	item_rect_changed.connect(calculate_aspect_ratio)

func calculate_aspect_ratio():
	material.set_shader_parameter("aspect_ratio", scale.y / scale.x)

