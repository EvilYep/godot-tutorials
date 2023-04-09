extends Control

@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	animation_player.play("transition");


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	color_rect.queue_free()
