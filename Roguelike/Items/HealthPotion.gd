extends Area2D

onready var tween: Tween = $Tween
onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _on_HealthPotion_body_entered(player: KinematicBody2D) -> void:
	collision_shape.set_deferred("disabled", true)
	player.health += 1
	SavedData.hp += 1
	var __ = tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.6, Tween.TRANS_SINE, Tween.EASE_IN)
	assert(__)
	__ = tween.interpolate_property(self, "position", position, position + Vector2.UP * 16, 0.6, Tween.TRANS_SINE, Tween.EASE_IN)
	assert(__)
	__ = tween.start()
	assert(__)

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	queue_free()
