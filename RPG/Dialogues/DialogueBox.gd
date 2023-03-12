extends CanvasLayer

onready var nine_patch_rect: NinePatchRect = $NinePatchRect
onready var name_label: RichTextLabel = $NinePatchRect/Name
onready var chat_label: RichTextLabel = $NinePatchRect/Chat

export(String, FILE, "*.json") var d_file

var dialogue := []
var current_line_id := 0
var active =  false

#### BUILT-IN ####

func _ready() -> void:
	nine_patch_rect.visible = false

func _input(event: InputEvent) -> void:
	if !active:
		return
	if event.is_action_pressed("ui_accept"):
		next_line()

#### VIRTUALS ####

#### LOGIC ####

func start() -> void:
	if active:
		return
	active = true
	dialogue = load_dialogue()
	current_line_id = -1
	next_line()
	nine_patch_rect.visible = true

func load_dialogue() -> Array:
	var file = File.new()
	if file.file_exists(d_file):
		file.open(d_file, file.READ)
		return parse_json(file.get_as_text())
	return []

func next_line() -> void:
	current_line_id += 1
	
	if current_line_id >= len(dialogue):
		$Timer.start()
		nine_patch_rect.visible = false
		return
	
	name_label.text = dialogue[current_line_id]["name"]
	chat_label.text = dialogue[current_line_id]["text"]

#### INPUTS ####

#### SIGNAL RESPONSES ####

func _on_Timer_timeout() -> void:
	active = false
