extends RigidBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	var mob_types = animated_sprite.sprite_frames.get_animation_names()
	animated_sprite.play(mob_types[randi() % mob_types.size()])

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
