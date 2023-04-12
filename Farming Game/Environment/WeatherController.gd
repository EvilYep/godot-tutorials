extends Node2D

@onready var rain: Control = $Rain
@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	if Global.weather == "none":
		Global.weather = "rain"
		var tween = create_tween()
		tween.tween_property(rain, "modulate", Color.WHITE, 3.0)
		timer.wait_time = randi_range(15, 35)
	elif Global.weather == "rain":
		Global.weather = "none"
		var tween = create_tween()
		tween.tween_property(rain, "modulate", Color.TRANSPARENT, 3.0)
		timer.wait_time = randi_range(25, 65)
	timer.start()
