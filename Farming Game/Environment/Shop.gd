extends Node2D

@onready var shop_menu: Control = $ShopMenu
@onready var seller: Sprite2D = $Seller
@onready var player_detector: CollisionShape2D = $Player_Detector/CollisionShape2D

func _ready() -> void:
	shop_menu.visible = false
	shop_menu.item_bought.connect(spawn_seedpack)
	Global.weather_changed.connect(_on_weather_changed)

func spawn_seedpack(plant: String) -> void:
	var node := plant.capitalize() + "Seedpack"
	get_node(node).visible = true

func swap_seller_visibility(weather: String) -> void:
	var tween = create_tween()
	if weather == "rain":
		tween.tween_property(seller, "modulate", Color.TRANSPARENT, 3.0)
	else:
		tween.tween_property(seller, "modulate", Color.WHITE, 3.0)

func _on_weather_changed(weather: String) -> void:
	player_detector.disabled = weather == "rain"
	swap_seller_visibility(weather)

func _on_area_2d_body_entered(_player: CharacterBody2D) -> void:
	shop_menu.visible = true
	shop_menu.update_menu()

func _on_area_2d_body_exited(_player: CharacterBody2D) -> void:
	shop_menu.visible = false
