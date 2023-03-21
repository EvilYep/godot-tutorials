extends StateMachine

#### BUILT-IN ####

func _init() -> void:
	add_state("idle")
	add_state("move")
	add_state("hurt")
	add_state("dead")

func _ready() -> void:
	set_state(states.move)

#### LOGIC ####

func update(_delta: float) -> void:
	if state == states.move:
		parent.chase()
		parent.move()

func get_transition() -> int:
	match state:
		states.idle:
			if parent.distance_to_player > parent.MAX_DISTANCE_TO_PLAYER or parent.distance_to_player < parent.MIN_DISTANCE_TO_PLAYER:
				return states.move
		states.move:
			if parent.distance_to_player < parent.MAX_DISTANCE_TO_PLAYER and parent.distance_to_player > parent.MIN_DISTANCE_TO_PLAYER:
				return states.idle
		states.hurt:
			if not animation_player.is_playing():
				return states.move
	return -1

func enter_state(new_state: int, _old_state: int) -> void:
	match new_state:
		states.idle:
			animation_player.play("idle")
		states.move:
			animation_player.play("move")
		states.hurt:
			animation_player.play("hurt")
		states.dead:
			animation_player.play("dead")
