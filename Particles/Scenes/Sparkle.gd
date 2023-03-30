extends Sprite2D

var time := 0.0
@export var power := 0.0
@export var speed := 1.0

func _process(delta):
	time = wrapf(time + delta * speed, -PI, PI)
	scale = Vector2.ONE + Vector2.ONE * sin(time) * power
