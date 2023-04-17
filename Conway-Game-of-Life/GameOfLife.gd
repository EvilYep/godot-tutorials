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

func _ready() -> void:
	var width_px = width * TILE_SIZE
	var height_px = height * TILE_SIZE
	
	camera.position = Vector2(width_px, height_px) / 2
	camera.zoom = Vector2(1920, 1080) / Vector2(width_px, height_px)
	
	for x in range(width):
		for y in range(height):
			_set_cell_state(CellState.DEAD, Vector2(x, y))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_play"):
		playing = not playing
	
	if event.is_action_pressed("click"):
		var pos = local_to_map(get_local_mouse_position())
		_toggle_cell_state(pos)

func _set_cell_state(alive: bool, pos: Vector2) -> void:
	if alive:
		set_cell(0, pos, 0, Vector2i(0, 0))
	else:
		set_cell(0, pos, 0, Vector2i(0, 0), 1)

func _get_cell_state(pos: Vector2i) -> CellState:
	return get_cell_tile_data(0, pos).get_custom_data("alive")

func _toggle_cell_state(pos: Vector2) -> void:
	_set_cell_state(1 - _get_cell_state(pos), pos)
