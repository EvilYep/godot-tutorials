extends Node2D

func _ready() -> void:
	Global.plant_harvested.connect(_update_ui)

func _update_ui(plant_name: String) -> void:
	var node = "UI/" + plant_name + "/Label"
	get_node(node).text = "= " + str(Global.count[plant_name])
