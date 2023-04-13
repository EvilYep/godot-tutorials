extends Camera2D

var starting_pos: Vector2
var player: RigidBody2D
var following_player := false:
	set(value):
		following_player = value
		if following_player == false:
			var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "position", starting_pos, 2.0)

func _ready() -> void:
	starting_pos = global_position
	player = get_tree().get_nodes_in_group("Player")[0]
	

func _physics_process(_delta: float) -> void:
	if following_player:
		if is_instance_valid(player):
			var player_pos = clamp(player.position.x, 0, 1000)
			global_position = Vector2(player_pos, starting_pos.y)
		else:
			following_player = false
