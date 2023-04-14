extends CanvasLayer

@onready var win_lose_state: Label = $Popup/WinLoseState
@onready var game_score_label: Label = $UI/ScoreLabel
@onready var popup_score_label: Label = $Popup/ScoreLabel
@onready var popup: Control = $Popup

func _ready() -> void:
	set_score()

func set_score() -> void:
	game_score_label.text = "Score : " + str(Game.score)
	popup_score_label.text = "Score : " + str(Game.score)

func popup_level_completed(win: bool, score: int) -> void:
	for n in 3:
		get_node("Popup/Stars/Star" + str(n + 1)).texture.region.position = Vector2(0, 0)
	popup.show()
	win_lose_state.text = "YOU WON !!" if win else "GAME OVER"
	popup_score_label.text = "Score : " + str(Game.score)
	if win and score > 1000:
		_pop_stars(3)
	elif win and score > 500:
		_pop_stars(2)
	elif win and score > 200:
		_pop_stars(1)

func _pop_stars(stars: int) -> void:
	await get_tree().create_timer(0.01).timeout
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	for n in stars:
		var node: TextureRect = get_node("Popup/Stars/Star" + str(n + 1))
		node.scale = Vector2.ZERO
		node.texture.region.position = Vector2(200, 0)
		tween.tween_property(node, "scale", Vector2(1, 1), 0.5)


func _on_restart_button_button_down() -> void:
	Game.restart_level()


func _on_next_level_button_button_down() -> void:
	Game.next_level()
