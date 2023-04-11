extends Node2D

func _on_area_2d_body_entered(player: CharacterBody2D) -> void:
	# It can only detect player since we set the collision layers/masks
	player.sell()
