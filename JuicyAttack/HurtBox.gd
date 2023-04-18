# Allows its owner to detect hits and take damage
@icon("res://Assets/HurtBox.svg")
class_name HurtBox
extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(hitbox: HitBox) -> void:
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.get_damage())
	if owner.has_method("knock_back"):
		owner.knock_back(hitbox.global_position)
