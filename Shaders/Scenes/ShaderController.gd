extends Camera2D

#### SIGNAL RESPONSES ####

func _on_v_slider_value_changed(value: float) -> void:
#	$CanvasLayer/ColorRect.get_material().set_shader_parameter("size_x", value)
#	$CanvasLayer/ColorRect.get_material().set_shader_parameter("size_y", value)
	$CanvasLayer/ColorRect.get_material().set_shader_parameter("offset", value)
	
