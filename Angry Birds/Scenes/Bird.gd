extends RigidBody2D

enum BirdState {
	IDLE,
	THROWN
}
var state: BirdState = BirdState.IDLE

func _ready() -> void:
	set_freeze_enabled(true)

func _process(_delta: float) -> void:
	if state == BirdState.THROWN and linear_velocity <= Vector2(2, 2):
		await get_tree().create_timer(5.0).timeout
		queue_free()

func throw_bird() -> void:
	set_freeze_enabled(false)
	state = BirdState.THROWN
