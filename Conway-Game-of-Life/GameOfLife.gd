extends TileMap

signal speed_changed(speed)

enum CellState {
	DEAD,
	ALIVE
}

const TILE_SIZE: int = 128

@export var width: int
@export var height: int
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

#### BUILT-IN ####

func _ready() -> void:
	var width_px = width * TILE_SIZE
	var height_px = height * TILE_SIZE
	
	camera.position = Vector2(width_px, height_px) / 2
	camera.zoom = Vector2(1920, 1080) / Vector2(width_px, height_px)
	
	next_generation_timer.wait_time = speed
	
	for x in range(width):
		for y in range(height):
			_set_cell_state(CellState.DEAD, Vector2(x, y))
	
	speed_changed.connect(_on_speed_changed)

#### INPUTS ####

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_play"):
		playing = not playing
	
	if event.is_action_pressed("click"):
		var pos = local_to_map(get_local_mouse_position())
		_toggle_cell_state(pos)

#### LOGIC ####

func _next_generation() -> void:
	if not playing: 
		return
	else:
		generation += 1
	
	generation_label.text = "Generation " + str(generation)


func _toggle_cell_state(pos: Vector2) -> void:
	_set_cell_state(1 - _get_cell_state(pos), pos)


func _set_cell_state(alive: bool, pos: Vector2) -> void:
	set_cell(0, pos, 0, Vector2i(0, 0), not alive)


func _get_cell_state(pos: Vector2i) -> CellState:
	return get_cell_tile_data(0, pos).get_custom_data("alive")

#### SIGNAL RESPONSES ####

func _on_speed_changed(s: float) -> void:
	speed_label.text = "Speed : " + str(s)
	next_generation_timer.wait_time = s


func _on_next_generation_timer_timeout() -> void:
	_next_generation()


func _on_speed_slider_value_changed(value: float) -> void:
	speed = value
