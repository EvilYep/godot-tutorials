extends StateMachine

#### BUILT-IN ####

func _init() -> void:
	add_state("idle")
	add_state("move")

func _ready() -> void:
	set_state(states.idle)

#### LOGIC ####

func update(_delta: float) -> void:
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
	return -1

func enter_state(new_state: int, _old_state: int) -> void:
	match new_state:
		states.idle:
			animation_player.play("idle")
		states.move:
			animation_player.play("move")

#### INPUTS ####

#### SIGNAL RESPONSES ####
