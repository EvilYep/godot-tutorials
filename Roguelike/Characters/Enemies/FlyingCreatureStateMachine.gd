extends StateMachine

#### BUILT-IN ####

func _init() -> void:
	add_state("chase")

func _ready() -> void:
	set_state(states.chase)

#### VIRTUALS ####

#### LOGIC ####

func update(_delta: float) -> void:
	if state == states.chase:
		parent.chase()
		parent.move()

func get_transition() -> int:
	return -1

func enter_state(new_state: int, _old_state: int) -> void:
	match new_state:
		states.chase:
			animation_player.play("fly")
#### INPUTS ####

#### SIGNAL RESPONSES ####
