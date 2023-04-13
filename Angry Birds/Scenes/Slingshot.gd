extends Node2D

signal sling_state_changed(state)

enum SlingState {
	IDLE,
	PULLING,
	BIRD_THROWN,
	RESET
}
var slingshot_state: SlingState:
	set(s_s):
		slingshot_state = s_s
		sling_state_changed.emit(slingshot_state)
var player: RigidBody2D

@onready var left_line: Line2D = $LeftLine
@onready var right_line: Line2D = $RightLine
@onready var slingshot_center: Vector2 = $Center.position
@onready var shot_arc: Line2D = $ShotArc

func _ready() -> void:
	sling_state_changed.connect(_on_sling_state_changed)
	Game.bird_despawned.connect(_on_bird_despawned)
	_reset_lines()
	slingshot_state = SlingState.IDLE
	player = get_tree().get_first_node_in_group("Player")
	player.position = slingshot_center

func _process(delta: float) -> void:
	match slingshot_state:
		SlingState.IDLE:
			pass
		SlingState.PULLING:
			if Input.is_action_pressed("left_mouse"):
				_pull(delta)
			else:
				_throw()
		SlingState.BIRD_THROWN:
			pass
		SlingState.RESET:
			pass

func _pull(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.distance_to(slingshot_center) > 100:
		mouse_pos = slingshot_center.direction_to(mouse_pos) * 100 + slingshot_center
		
	player.position = mouse_pos
	left_line.points[0] = mouse_pos
	right_line.points[0] = mouse_pos
	
	var distance = mouse_pos - slingshot_center
	var velocity = distance / 2.5 * mouse_pos
	var point_pos = slingshot_center
	shot_arc.clear_points()
	for i in 5000:
		shot_arc.add_point(point_pos)
		velocity.y += 980 * delta #980 = default gravity
		point_pos += velocity * delta
		if point_pos.y > shot_arc.position.y:
			break

func _throw() -> void:
	shot_arc.clear_points()
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.distance_to(slingshot_center) > 100:
		mouse_pos = slingshot_center.direction_to(mouse_pos) * 100 + slingshot_center
	var velocity =  mouse_pos - slingshot_center
	
	player.throw_bird()
	player.apply_impulse(velocity / 2.5 * mouse_pos, Vector2())
	
	slingshot_state = SlingState.BIRD_THROWN
	_reset_lines()
	Game.current_game_state = Game.GameState.PLAY
	get_tree().get_first_node_in_group("Camera").following_player = true

func _reset_lines() -> void:
	left_line.points[0] = slingshot_center
	right_line.points[0] = slingshot_center

func _on_sling_state_changed(_new_state: SlingState) -> void:
	match slingshot_state:
		SlingState.RESET:
			if not get_tree().get_nodes_in_group("Birds").is_empty():
				player = get_tree().get_first_node_in_group("Player") as RigidBody2D
				var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
				tween.tween_property(player, "position", slingshot_center, 0.5)
				await tween.finished
				slingshot_state = SlingState.IDLE

func _on_touch_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if slingshot_state == SlingState.IDLE:
		if event is InputEventMouseButton and event.pressed:
			slingshot_state = SlingState.PULLING

func _on_bird_despawned() -> void:
	await get_tree().create_timer(0.1).timeout
	slingshot_state = SlingState.RESET
