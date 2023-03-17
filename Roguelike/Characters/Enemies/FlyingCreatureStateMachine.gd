extends StateMachine

#### BUILT-IN ####

func _init() -> void:
	add_state("chase")
	add_state("hurt")
	add_state("dead")

func _ready() -> void:
	set_state(states.chase)

#### VIRTUALS ####

#### LOGIC ####

func update(_delta: float) -> void:
	if state == states.chase:
		parent.chase()
		parent.move()

func get_transition() -> int:
	match state:
		states.hurt:
			if not animation_player.is_playing():
				return states.chase
	return -1

func enter_state(new_state: int, _old_state: int) -> void:
	match new_state:
		states.chase:
			animation_player.play("fly")
		states.hurt:
			animation_player.play("hurt")
		states.dead:
			animation_player.play("dead")
#### INPUTS ####

#### SIGNAL RESPONSES ####
