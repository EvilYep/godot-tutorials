extends Weapon

const ARROW_SCENE = preload("res://Weapons/Arrow.tscn")

func shoot(offset: int) -> void:
	var arrow : Area2D = ARROW_SCENE.instance()
	get_tree().current_scene.add_child(arrow)
	arrow.throw(global_position, Vector2.LEFT.rotated(deg2rad(rotation_degrees + offset)), 400)

func triple_shot() -> void:
	shoot(-12)
	shoot(0)
	shoot(12)
