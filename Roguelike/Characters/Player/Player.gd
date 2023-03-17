extends Character
class_name Player

onready var sword: Node2D = $Sword
onready var sword_hitbox: Area2D = $Sword/Node2D/Sprite/Hitbox
onready var sword_animation_player: AnimationPlayer = sword.get_node("SwordAnimationPlayer")

var mouse_direction := Vector2.ZERO

#### ACCESSORS ####

func is_class(value: String): return value == "Player" or .is_class(value)
func get_class() -> String: return "Player"

#### BUILT-IN ####

func _process(_delta: float) -> void:
	mouse_direction = (get_global_mouse_position() - global_position).normalized()
	animated_sprite.flip_h = mouse_direction.x < 0
	_rotate_sword()
	
	if Input.is_action_just_pressed("attack") and not sword_animation_player.is_playing():
		sword_animation_player.play("attack")

#### LOGIC ####

func get_input() -> void:
	mov_direction = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)

func _rotate_sword() -> void:
	sword.rotation = mouse_direction.angle()
	sword_hitbox.knockback_direction = mouse_direction
	if sword.scale.y == 1 and mouse_direction.x < 0:
		sword.scale.y = -1
	if sword.scale.y == -1 and mouse_direction.x > 0:
		sword.scale.y = 1
