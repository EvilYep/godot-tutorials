@tool
extends Sprite2D

func _process(_delta: float) -> void:	# for editor purposes, to optimize
	_zoom_changed()

func _zoom_changed() -> void:
	material.set_shader_parameter("y_zoom", get_viewport_transform().get_scale().y)

func _on_item_rect_changed() -> void:
	material.set_shader_parameter("scale", scale)
