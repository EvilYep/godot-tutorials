extends TileMap

signal speed_changed(speed)

# Used as a boolean all over the script, 0 == false == DEAD, 1 == true == ALIVE
enum CellState {
	DEAD,
	ALIVE
}

const TILE_SIZE: int = 128

@export var width: int = 96
@export var height: int = 54
@export var speed: float = 0.1:
	set(s):
		speed = s
		speed_changed.emit(speed)

@onready var camera: Camera2D = $Camera
@onready var next_generation_timer: Timer = $NextGenerationTimer

@onready var speed_label: Label = $UI/SpeedLabel
@onready var generation_label: Label = $UI/GenerationLabel

var playing := false
var generation: int = 0
var temp_grid : Array[Array]

#### BUILT-IN ####

func _ready() -> void:
	var width_px = width * TILE_SIZE
	var height_px = height * TILE_SIZE
	
	camera.position = Vector2(width_px, height_px) / 2
	camera.zoom = Vector2(1920, 1080) / Vector2(width_px, height_px)
	
	next_generation_timer.wait_time = speed
	
	for x in range(width):
		temp_grid.append([])
		for y in range(height):
			temp_grid[x].append(CellState.DEAD)
			_set_cell_state(CellState.DEAD, Vector2(x, y))
	
	speed_changed.connect(_on_speed_changed)

#### INPUTS ####

func _unhandled_input(event: InputEvent) -> void:
	var pos = local_to_map(get_local_mouse_position())
	if event.is_action_pressed("toggle_play"):
		playing = not playing
	
	if event.is_action_pressed("click"):
		_toggle_cell_state(pos)
	
	if event.is_action_pressed("right_click"):
		_place_glider(pos)

#### LOGIC ####

func _next_generation() -> void:
	if not playing: 
		return
	
	# calculate next generation
	for x in range(width):
		for y in range(height):
			var live_neighbours = _count_live_neighbours(Vector2(x, y))
			
			if _is_alive(Vector2(x, y)):
				temp_grid[x][y] = CellState.ALIVE if live_neighbours in [2, 3] else CellState.DEAD
			else:
				temp_grid[x][y] = CellState.ALIVE if live_neighbours == 3 else CellState.DEAD
	
	# update grid
	for x in range(width):
		for y in range(height):
			_set_cell_state(temp_grid[x][y], Vector2(x, y))
	
	# update UI
	generation += 1
	generation_label.text = "Generation " + str(generation)


func _toggle_cell_state(pos: Vector2) -> void:
	_set_cell_state(CellState.ALIVE - _is_alive(pos), pos)


func _set_cell_state(alive: bool, pos: Vector2) -> void:
	set_cell(0, pos, 0, Vector2i(0, 0), not alive)


func _is_alive(pos: Vector2i) -> CellState:
	var cell = get_cell_tile_data(0, pos)
	if cell:
		return cell.get_custom_data("alive")
	else:
		return CellState.DEAD


func _count_live_neighbours(pos: Vector2) -> int:
	var live_neightbours: int = 0
	for x_off in [-1, 0, 1]:
		for y_off in [-1, 0, 1]:
			if x_off != y_off or x_off != 0:
				if _is_alive(pos + Vector2(x_off, y_off)):
					live_neightbours += 1
	return live_neightbours


func _place_glider(pos: Vector2)-> void:
	_set_cell_state(CellState.ALIVE, pos + Vector2(-1, 0))
	_set_cell_state(CellState.ALIVE, pos + Vector2(0, -1))
	_set_cell_state(CellState.ALIVE, pos + Vector2(1, -1))
	_set_cell_state(CellState.ALIVE, pos + Vector2(1, 0))
	_set_cell_state(CellState.ALIVE, pos + Vector2(1, 1))

#### SIGNAL RESPONSES ####

func _on_speed_changed(s: float) -> void:
	speed_label.text = "Speed : " + str(s)
	next_generation_timer.wait_time = s


func _on_next_generation_timer_timeout() -> void:
	_next_generation()


func _on_speed_slider_value_changed(value: float) -> void:
	speed = value
