extends Enemy

onready var hitbox: Area2D = $Hitbox

#### BUILT-IN ####

func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()

#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
