extends Node2D

enum SlingState {
	IDLE,
	PULLING,
	BIRD_THROWN,
	RESET
}
var slingshot_state: SlingState
var player: RigidBody2D

@onready var left_line: Line2D = $LeftLine
@onready var right_line: Line2D = $RightLine
@onready var slingshot_center: Vector2 = $Center.position

func _ready() -> void:
	_reset_lines()
	slingshot_state = SlingState.IDLE
	player = get_tree().get_nodes_in_group("Player")[0]
	player.position = slingshot_center

func _process(_delta: float) -> void:
	match slingshot_state:
		SlingState.IDLE:
			pass
		SlingState.PULLING:
			if Input.is_action_pressed("left_mouse"):
				_pull()
			else:
				_throw()
		SlingState.BIRD_THROWN:
			pass
		SlingState.RESET:
			pass

func _pull() -> void:
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.distance_to(slingshot_center) > 100:
		mouse_pos = (mouse_pos - slingshot_center).normalized() * 100 + slingshot_center
	player.position = mouse_pos
	left_line.points[0] = mouse_pos
	right_line.points[0] = mouse_pos

func _throw() -> void:
	var mouse_pos = get_global_mouse_position()
	var distance = mouse_pos.distance_to(slingshot_center)
	var velocity = slingshot_center - mouse_pos
	player.throw_bird()
	player.apply_impulse(velocity / 50 * distance, Vector2())
	slingshot_state = SlingState.BIRD_THROWN
	_reset_lines()
	#Game.current_game_state = 

func _reset_lines() -> void:
	left_line.points[0] = slingshot_center
	right_line.points[0] = slingshot_center

func _on_touch_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if slingshot_state == SlingState.IDLE:
		if event is InputEventMouseButton and event.pressed:
			slingshot_state = SlingState.PULLING
