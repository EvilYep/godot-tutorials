extends Sprite2D

@export var speed: float = 1
@export var texture_size: Vector2
@export var camera_dependant: bool

var custom_offset: float = 0

@onready var camera: Camera2D = $"../Camera2D"

func _process(_delta: float) -> void:
	if camera_dependant:
		custom_offset = camera.global_position.x * 0.05
	else:
		custom_offset += speed * 0.05
	region_rect = Rect2(custom_offset, 0, texture_size.x, texture_size.y)
