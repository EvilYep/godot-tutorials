extends CustomRoom

const WEAPONS := [
	preload("res://Weapons/Hammer.tscn"),
	preload("res://Weapons/Axe.tscn"),
]

onready var weapon_pos: Position2D = $WeaponPos

func _ready() -> void:
	var weapon : Node2D = WEAPONS[randi() % WEAPONS.size()].instance()
	weapon.position = weapon_pos.position
	weapon.on_floor = true
	add_child(weapon)
