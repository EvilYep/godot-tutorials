extends StaticBody2D

var plant: int = -1
var plant_name := ""
var plant_growing := false
var plant_grown := false

@onready var growth_timer: Timer = $GrowthTimer
@onready var plant_sprite: AnimatedSprite2D = $Ground/Plant

func _on_area_area_entered(plant_seed: Area2D) -> void:
	plant = Global.selected_plant
	if not plant_growing:
		if plant != -1:
			plant_name = Global.get_selected_plant_name(plant)
			plant_growing = true
			growth_timer.wait_time = plant_seed.owner.growth_speed
			growth_timer.start()
			plant_sprite.play(plant_name + "_growing")

func _on_growth_timer_timeout() -> void:
	if plant_sprite.frame == 0:
		plant_sprite.frame = 1
		growth_timer.start()
	elif plant_sprite.frame == 1:
		plant_sprite.frame = 2
		plant_grown = true

func _on_area_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		if plant_grown:
			Global.count[plant_name] += 1
			Global.plant_harvested.emit(plant_name)
			plant_growing = false
			plant_grown = false
			plant_sprite.play("none")
