extends Character
class_name Player

const DUST_SCENE := preload("res://FX/Dust.tscn")
onready var dust_position: Position2D = $DustPosition

onready var parent: Node2D = get_parent()
onready var weapons: Node2D = $Weapons
var current_weapon: Weapon

signal weapon_switched(prev_index, new_index)
signal weapon_picked_up(weapon_texture)
signal weapon_dropped(index)

var mouse_direction := Vector2.ZERO

enum {UP, DOWN}

#### ACCESSORS ####

func is_class(value: String): return value == "Player" or .is_class(value)
func get_class() -> String: return "Player"

#### BUILT-IN ####

func _ready() -> void:
	emit_signal("weapon_picked_up", weapons.get_child(0).get_texture())
	_restore_saved_state()

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

func _restore_saved_state() -> void:
	self.health = SavedData.hp
	for weapon in SavedData.weapons:
		weapon = weapon.duplicate()
		weapon.position = Vector2.ZERO
		weapons.add_child(weapon)
		weapon.hide()
		emit_signal("weapon_picked_up", weapon.get_texture())
		emit_signal("weapon_switched", weapons.get_child_count() - 2, weapons.get_child_count() - 1)
	current_weapon = weapons.get_child(SavedData.equipped_weapon_index)
	current_weapon.show()
	emit_signal("weapon_switched", weapons.get_child_count() - 1, SavedData.equipped_weapon_index)

func switch_weapon(direction: int) -> void:
	var prev_index: int = current_weapon.get_index()
	var index = prev_index
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
	SavedData.equipped_weapon_index = index
	emit_signal("weapon_switched", prev_index, index)

func pick_up_weapon(weapon: Weapon) -> void:
	SavedData.weapons.append(weapon.duplicate())
	var prev_index := SavedData.equipped_weapon_index
	var new_index := weapons.get_child_count()
	SavedData.equipped_weapon_index = new_index
	weapon.get_parent().call_deferred("remove_child", weapon)
	weapons.call_deferred("add_child", weapon)
	weapon.set_deferred("owner", weapons)
	current_weapon.hide()
	current_weapon.cancel_attack()
	current_weapon = weapon
	emit_signal("weapon_picked_up", weapon.get_texture())
	emit_signal("weapon_switched", prev_index, new_index)

func drop_weapon() -> void:
	SavedData.weapons.remove(current_weapon.get_index() - 1)
	var weapon_to_drop: Weapon = current_weapon
	switch_weapon(UP)
	emit_signal("weapon_dropped", weapon_to_drop.get_index())
	
	weapons.call_deferred("remove_child", weapon_to_drop)
	get_parent().call_deferred("add_child", weapon_to_drop)
	weapon_to_drop.set_owner(get_parent())
	yield(weapon_to_drop.tween, "tree_entered")
	weapon_to_drop.show()
	
	var throw_direction := (get_global_mouse_position() - position).normalized()
	weapon_to_drop.interpolate_pos(position, position + throw_direction * 50)

func cancel_attack() -> void:
	current_weapon.cancel_attack()

func spawn_dust() -> void:
	var dust := DUST_SCENE.instance()
	dust.position = dust_position.global_position
	parent.add_child_below_node(parent.get_child(get_index() - 1), dust)

func switch_camera() -> void:
	var main_scene_camera = get_tree().current_scene.get_node("Camera2D")
	main_scene_camera.position = position
	main_scene_camera.current = true
	get_node("Camera2D").current = false
