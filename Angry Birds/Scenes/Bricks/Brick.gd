extends RigidBody2D

var hp := 5.0

@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if is_instance_valid(body):
		if body is RigidBody2D and body.is_in_group("Player"):
			var damage = body.linear_velocity.length() * 0.1
			if damage > 1 :
				Utils.pop_score(global_position, damage)
			hp -= damage
			Game.score += damage
			if hp <= 0:
				queue_free()
			elif hp <= 2.5:
				sprite.frame = 1
