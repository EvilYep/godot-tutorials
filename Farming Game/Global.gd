extends Node

signal update_plant_count(plant_name: String)
signal update_coins()

enum Plants {
	CARROT,
	ONION,
	BERRY,
	RANDOM
}
var selected_plant: int = -1

var count: Dictionary = {
	"carrot": 0,
	"onion": 0, 
	"berry": 0
}
var price: Dictionary = {
	"carrot": 5,
	"onion": 8,
	"berry": 15
}
var owned: Dictionary = {
	"carrot": true,
	"onion": true,
	"berry": false,
	"random": false
}
var coins: int = 0

func get_selected_plant_name(index: int) -> String:
	return Plants.keys()[index].to_lower()
