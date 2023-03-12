extends Area2D

onready var animation_player: AnimationPlayer = get_parent().get_node("AnimationPlayer")

export (int) var damage = 10

#### BUILT-IN ####

func _ready() -> void:
	pass

#### VIRTUALS ####

#### LOGIC ####

func attack() -> void:
	animation_player.play("Attack")

#### INPUTS ####

#### SIGNAL RESPONSES ####

func _on_Hitbox_body_entered(body: Node) -> void:
	if body.has_method("handle_hit"):
		body.handle_hit(damage)

func _on_Hitbox_body_exited(_body: Node) -> void:
	pass # Replace with function body.
