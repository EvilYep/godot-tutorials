extends Node2D

@onready var coin_label: Label = $UI/coins/Label

func _ready() -> void:
	Global.update_plant_count.connect(_update_ui)
	Global.update_coins.connect(_update_ui_coins)

func _update_ui(plant_name: String) -> void:
	var node = "UI/" + plant_name + "/Label"
	get_node(node).text = "= " + str(Global.count[plant_name])

func _update_ui_coins() -> void:
	coin_label.text = "= " + str(Global.coins)
