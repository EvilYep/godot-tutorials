extends Sprite2D

@export var noise: FastNoiseLite
@export var speed := 20.0

var pos := 0.0

@onready var og_scale = scale

func _ready() -> void:
	pos = randi_range(0, 1000)

func _process(delta: float) -> void:
	pos += delta * speed
	scale = og_scale * (1 + noise.get_noise_1d(pos) * 0.2)

