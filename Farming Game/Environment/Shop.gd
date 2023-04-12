extends Node2D

@onready var shop_menu: Control = $ShopMenu

func _ready() -> void:
	shop_menu.visible = false
	shop_menu.item_bought.connect(spawn_seedpack)

func spawn_seedpack(plant: String) -> void:
	var node := plant.capitalize() + "Seedpack"
	get_node(node).visible = true

func _on_area_2d_body_entered(_player: CharacterBody2D) -> void:
	shop_menu.visible = true
	shop_menu.update_menu()

func _on_area_2d_body_exited(_player: CharacterBody2D) -> void:
	shop_menu.visible = false
