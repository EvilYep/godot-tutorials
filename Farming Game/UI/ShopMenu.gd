extends Control

signal item_bought(item: String)

const BERRY_FRAME := 53
const RANDOM_FRAME := 64

var items := [
	Global.Plants.BERRY, 
	Global.Plants.RANDOM
]
var item_id := 0
var displayed_item: int = items[item_id]
var price: int = 0
var plant_name := ""

@onready var icon: Sprite2D = $ColorRect/Icon
@onready var price_label: Label = $ColorRect/Price
@onready var buy_button: Button = $ColorRect/BuyButton
@onready var buy_label: Label = $ColorRect/BuyLabel

func _ready() -> void:
	swap_item()
	swap_item()

func swap_item() -> void:
	item_id += 1
	displayed_item = items[item_id % items.size()]
	plant_name = Global.get_selected_plant_name(displayed_item)
	
	match displayed_item:
		Global.Plants.BERRY:
			update_menu(BERRY_FRAME, 100)
		Global.Plants.RANDOM:
			update_menu(RANDOM_FRAME, 250)

func buy() -> void:
	Global.coins -= price
	Global.owned[plant_name] = true
	Global.update_coins.emit()
	item_bought.emit(plant_name)
	update_menu(icon.frame, price)

func update_menu(frame: int = icon.frame, p: int = price) -> void:
	icon.frame = frame
	price = p
	price_label.text = str(p)
	buy_button.visible = can_buy()
	buy_label.text = "Buy" if can_buy() else ""

func can_buy() -> bool:
	return Global.coins >= price and Global.owned[plant_name] == false

func _on_button_left_pressed() -> void:
	swap_item()

func _on_button_right_pressed() -> void:
	swap_item()

func _on_buy_button_pressed() -> void:
	if can_buy():
		buy()


