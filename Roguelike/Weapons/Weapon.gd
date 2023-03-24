extends Node2D
class_name Weapon, "res://Assets/weapon_icon.png"

export(bool) var on_floor := false

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var charge_particles: Particles2D = $Node2D/Sprite/ChargeParticles
onready var hitbox: Area2D = $Node2D/Sprite/Hitbox
onready var player_detector: Area2D = $PlayerDetector
onready var tween: Tween = $Tween
onready var cool_down_timer: Timer = $CoolDownTimer
onready var ui: CanvasLayer = $UI
onready var ability_icon: TextureProgress = $UI/AbilityIcon

var can_active_ability := true

#### ACCESSORS ####

func is_class(value: String): return value == "Weapon" or .is_class(value)
func get_class() -> String: return "Weapon"

#### BUILT-IN ####

func _ready() -> void:
	if not on_floor:
		player_detector.set_collision_mask_bit(0, false)
		player_detector.set_collision_mask_bit(1, false)

#### VIRTUALS ####

#### LOGIC ####

func get_input() -> void:
	if Input.is_action_just_pressed("attack") and not animation_player.is_playing():
		animation_player.play("charge")
	elif Input.is_action_just_released("attack"):
		if animation_player.is_playing() and animation_player.current_animation == "charge":
			animation_player.play("attack")
		elif charge_particles.emitting == true:
			animation_player.play("strong_attack")
	elif Input.is_action_just_pressed("active_ability") and animation_player.has_animation("active_ability") and not is_busy() and can_active_ability:
		can_active_ability = false
		cool_down_timer.start()
		ui.recharge_active_ability(cool_down_timer.wait_time)
		animation_player.play("active_ability")

func move(mouse_direction: Vector2) -> void:
	if not animation_player.is_playing() or animation_player.current_animation == "charge":
		rotation = mouse_direction.angle()
		hitbox.knockback_direction = mouse_direction
		if scale.y == 1 and mouse_direction.x < 0:
			scale.y = -1
		if scale.y == -1 and mouse_direction.x > 0:
			scale.y = 1

func cancel_attack() -> void:
	animation_player.play("cancel_attack")

func is_busy() -> bool:
	return animation_player.is_playing() or charge_particles.emitting == true

func interpolate_pos(initial_pos: Vector2, final_pos: Vector2) -> void:
	var __ = tween.interpolate_property(self, "position", initial_pos, final_pos, 0.8, Tween.TRANS_QUART, Tween.EASE_OUT)
	assert(__)
	__ = tween.start()
	assert(__)
	player_detector.set_collision_mask_bit(0, true)

func show() -> void:
	ability_icon.show()
	.show()

func hide() -> void:
	ability_icon.hide()
	.hide()

#### INPUTS ####

#### SIGNAL RESPONSES ####

func _on_PlayerDetector_body_entered(body: KinematicBody2D) -> void:
	if body != null:
		player_detector.set_collision_mask_bit(0, false)
		player_detector.set_collision_mask_bit(1, false)
		body.pick_up_weapon(self)
		position = Vector2.ZERO
	else:
		var __ = tween.stop_all()
		assert(__)
		player_detector.set_collision_mask_bit(1, true)

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	player_detector.set_collision_mask_bit(1, true)

func _on_CoolDownTimer_timeout() -> void:
	can_active_ability = true
