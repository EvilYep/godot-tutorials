extends RigidBody2D

func _ready() -> void:
	set_freeze_enabled(true)

func throw_bird() -> void:
	set_freeze_enabled(false)
