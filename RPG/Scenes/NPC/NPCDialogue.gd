extends Area2D

#### BUILT-IN ####

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and len(get_overlapping_bodies()) > 0:
		start_dialogue()

#### VIRTUALS ####

#### LOGIC ####

func start_dialogue() -> void:
	var dialogue = get_parent().get_node("DialogueBox")
	if dialogue:
		dialogue.start()

#### INPUTS ####

#### SIGNAL RESPONSES ####
