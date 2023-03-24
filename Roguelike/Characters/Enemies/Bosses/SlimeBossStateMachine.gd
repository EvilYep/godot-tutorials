extends StateMachine

onready var jump_timer: Timer = parent.get_node("JumpTimer")
onready var hitbox: Area2D = parent.get_node("Hitbox")

var can_jump := false

func _init() -> void:
	add_state("idle")
	add_state("jump")
	add_state("hurt")
	add_state("dead")

func _ready() -> void:
	set_state(states.idle)

func update(_delta: float) -> void:
	if state == states.jump:
		parent.chase()
		parent.move()

func get_transition() -> int:
	match state:
		states.idle:
			if can_jump:
				return states.jump
		states.jump:
			if not animation_player.is_playing():
				return states.idle
		states.hurt:
			if not animation_player.is_playing():
				return states.idle
	return -1

func enter_state(new_state: int, _old_state: int) -> void:
	match new_state:
		states.idle:
			animation_player.play("idle")
		states.jump:
			if is_instance_valid(parent.player):
				parent.path = [parent.global_position, parent.player.global_position]
				hitbox.knockback_direction = (parent.path[1] - parent.path[0]).normalized()
			animation_player.play("jump")
		states.hurt:
			animation_player.play("hurt")
		states.dead:
			animation_player.play("dead")

func exit_state(_state_exited: int) -> void:
	if state == states.jump:
		can_jump = false
		jump_timer.start()

func _on_JumpTimer_timeout() -> void:
	can_jump = true
