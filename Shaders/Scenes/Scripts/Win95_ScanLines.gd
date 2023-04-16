extends Control

@onready var start_button: Button = $TaskBar/StartButton
@onready var close_button: Button = $Window/CloseButton
@onready var window: Panel = $Window

func _on_start_button_pressed() -> void:
	window.visible = true

func _on_close_button_pressed() -> void:
	window.visible = false
