extends Node

signal plant_harvested(plant_name: String)

enum Plants {
	CARROT,
	ONION,
}

var selected_plant: int = -1

var count: Dictionary = {
	"carrot": 0,
	"onion": 0
}

func get_selected_plant_name(index: int) -> String:
	return Plants.keys()[index].to_lower()
