extends RigidBody2D

var hp := 150.0

@onready var sprite: Sprite2D = $Sprite

func _on_body_entered(body: Node) -> void:
	if is_instance_valid(body):
		if body is RigidBody2D:
			if body.is_in_group("Player"):
				queue_free()
			else:
				var damage = body.linear_velocity.length() * 0.1
				if damage > 1 :
					Utils.pop_score(global_position, damage)
				hp -= damage
				Game.score += damage * 10
				if hp <= 0:
					queue_free()
				elif hp <= 75:
					sprite.frame = 1
