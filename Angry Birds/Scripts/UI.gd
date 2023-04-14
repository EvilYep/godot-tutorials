extends CanvasLayer

@onready var score_label: Label = $UI/ScoreLabel

func set_score() -> void:
	score_label.text = "Score : " + str(Game.score)
