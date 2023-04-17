extends TileMap

enum CellState {
	DEAD,
	ALIVE
}

const TILE_SIZE: int = 128

@export var width: int
@export var height: int

@onready var camera: Camera2D = $Camera2D

var playing := false
var temp_field := []

func _ready() -> void:
	var width_px = width * TILE_SIZE
	var height_px = height * TILE_SIZE
	
	camera.position = Vector2(width_px, height_px) / 2
	camera.zoom = Vector2(1920, 1080) / Vector2(width_px, height_px)
	
	for x in range(width):
		var temp = []
		
		for y in range(height):
			_set_cell_state(CellState.DEAD, x, y)
			temp.append(CellState.DEAD)

func _set_cell_state(alive: bool, x: int, y: int) -> void:
	if alive:
		set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0))
	else:
		set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0), 1)
