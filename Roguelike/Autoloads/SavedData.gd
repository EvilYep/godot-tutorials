extends Node

var hp := 4
var weapons := []
var equipped_weapon_index := 0

var num_floor := 0

func reset_data() -> void:
	num_floor = 0
	
	hp = 4
	weapons = []
	equipped_weapon_index = 0
