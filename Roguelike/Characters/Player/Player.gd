extends Character
class_name Player

onready var weapons: Node2D = $Weapons
var current_weapon: Weapon

var mouse_direction := Vector2.ZERO

enum {UP, DOWN}

#### ACCESSORS ####

func is_class(value: String): return value == "Player" or .is_class(value)
func get_class() -> String: return "Player"

#### BUILT-IN ####

func _ready() -> void:
	current_weapon = weapons.get_child(0)

func _process(_delta: float) -> void:
	mouse_direction = (get_global_mouse_position() - global_position).normalized()
	animated_sprite.flip_h = mouse_direction.x < 0
	current_weapon.move(mouse_direction)

#### LOGIC ####

func get_input() -> void:
	mov_direction = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
	
	if not current_weapon.is_busy():
		if Input.is_action_just_released("previous_weapon"):
			switch_weapon(UP)
		elif Input.is_action_just_released("next_weapon"):
			switch_weapon(DOWN)
		elif Input.is_action_just_pressed("throw") and current_weapon.get_index() != 0:
			drop_weapon()
	
	current_weapon.get_input()

func switch_weapon(direction: int) -> void:
	var index: int = current_weapon.get_index()
	if direction == UP:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	else:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0
	
	current_weapon.hide()
	current_weapon = weapons.get_child(index)
	current_weapon.show()

func pick_up_weapon(weapon: Weapon) -> void:
	weapon.get_parent().call_deferred("remove_child", weapon)
	weapons.call_deferred("add_child", weapon)
	weapon.set_deferred("owner", weapons)
	current_weapon.hide()
	current_weapon.cancel_attack()
	current_weapon = weapon

func drop_weapon() -> void:
	var weapon_to_drop: Weapon = current_weapon
	switch_weapon(UP)
	weapons.call_deferred("remove_child", weapon_to_drop)
	get_parent().call_deferred("add_child", weapon_to_drop)
	weapon_to_drop.set_owner(get_parent())
	yield(weapon_to_drop.tween, "tree_entered")
	weapon_to_drop.show()
	
	var throw_direction := (get_global_mouse_position() - position).normalized()
	weapon_to_drop.interpolate_pos(position, position + throw_direction * 50)

func cancel_attack() -> void:
	current_weapon.cancel_attack()

func switch_camera() -> void:
	var main_scene_camera = get_tree().current_scene.get_node("Camera2D")
	main_scene_camera.position = position
	main_scene_camera.current = true
	get_node("Camera2D").current = false
