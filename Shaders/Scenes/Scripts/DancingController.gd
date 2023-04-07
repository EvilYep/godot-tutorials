extends HBoxContainer

var amplitude: Vector2 = Vector2(10.0, 5.0):
	get:
		return amplitude
	set(value):
		amplitude = value
		x_label.text = str(amplitude.x)
		y_label.text = str(amplitude.y)
var speed: float = 1.0:
	get:
		return speed
	set(value):
		speed = value
		speed_label.text = str(speed)

@onready var sprite: Sprite2D = $"../Sprite2D"
@onready var x_label: Label = $VBoxContainer/XLabel
@onready var y_label: Label = $VBoxContainer2/YLabel
@onready var speed_label: Label = $VBoxContainer3/SpeedLabel

#### SIGNAL RESPONSES ####

func _on_x_slider_value_changed(value: float) -> void:
	amplitude.x = value
	sprite.material.set_shader_parameter("amplitude", amplitude)


func _on_y_slider_value_changed(value: float) -> void:
	amplitude.y = value
	sprite.material.set_shader_parameter("amplitude", amplitude)



func _on_speed_slider_value_changed(value: float) -> void:
	speed = value
	sprite.material.set_shader_parameter("speed", speed)
