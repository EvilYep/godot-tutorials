extends Node2D
class_name Weapon, "res://Assets/weapon_icon.png"

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var charge_particles: Particles2D = $Node2D/Sprite/ChargeParticles
onready var hitbox: Area2D = $Node2D/Sprite/Hitbox

#### ACCESSORS ####

func is_class(value: String): return value == "Weapon" or .is_class(value)
func get_class() -> String: return "Weapon"

#### BUILT-IN ####

func _ready() -> void:
	pass

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

#### INPUTS ####

#### SIGNAL RESPONSES ####
