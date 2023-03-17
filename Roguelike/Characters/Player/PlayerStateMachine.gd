extends StateMachine

#### BUILT-IN ####

func _init() -> void:
	add_state("idle")
	add_state("move")
	add_state("hurt")
	add_state("dead")

func _ready() -> void:
	set_state(states.idle)

#### LOGIC ####

func update(_delta: float) -> void:
	if state == states.idle or state == states.move:
		parent.get_input()
		parent.move()

func get_transition() -> int:
	match state:
		states.idle:
			if parent.velocity.length() > 10:
				return states.move
		states.move:
			if parent.velocity.length() < 10:
				return states.idle
		states.hurt:
			if not animation_player.is_playing():
				return states.idle
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

#### INPUTS ####

#### SIGNAL RESPONSES ####
