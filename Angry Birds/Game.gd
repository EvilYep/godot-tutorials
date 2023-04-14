extends Node2D

signal state_changed(state)
signal bird_despawned
signal score_changed(score)

enum GameState {
	START,
	PLAY,
	WIN,
	LOSE
}
var current_game_state: GameState = GameState.START:
	set(st):
		current_game_state = st
		state_changed.emit(current_game_state)

var score: int = 0:
	set(value):
		score = int(value)
		score_changed.emit(score)

var pigs: Array[Node]
var birds: Array[Node]

func _ready() -> void:
	state_changed.connect(_on_game_state_changed)
	score_changed.connect(_on_score_changed)

func _process(_delta: float) -> void:
	match current_game_state:
		GameState.PLAY:
			birds = get_tree().get_nodes_in_group("Birds")
			pigs = get_tree().get_nodes_in_group("Pigs")
			if pigs.is_empty():
				current_game_state = GameState.WIN
			elif birds.is_empty():
				current_game_state = GameState.LOSE

func _on_game_state_changed(_new_state: GameState) -> void:
	match current_game_state:
		GameState.START:
			pass
		GameState.PLAY:
			pass
		GameState.WIN:
			print("win")
		GameState.LOSE:
			print("loser")

func _on_score_changed(_new_score) -> void:
	var score_label = get_tree().get_first_node_in_group("UI")
	score_label.set_score()
