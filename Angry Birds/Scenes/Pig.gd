extends RigidBody2D

var hp := 200.0

@onready var sprite: Sprite2D = $Sprite

func _on_body_entered(body: Node) -> void:
	if is_instance_valid(body):
		if body is RigidBody2D:
			var damage = int(body.linear_velocity.length() * 0.1)
			if damage > 1 :
				Utils.pop_score(global_position, damage)
				Game.score += int(float(damage) * 10 / (Game.level + 1))
			
			if body.is_in_group("Player"):
				queue_free()
			else:
				hp -= damage
				if hp <= 0:
					queue_free()
				elif hp <= 100:
					sprite.frame = 1
