extends CheckBox

func _ready() -> void:
	toggled.connect(_on_toggled)

func _on_toggled(_toggled: bool) -> void:
	get_tree().call_group("CollisionShapes", "set_visible", _toggled)
	for child in get_tree().get_nodes_in_group("CollisionShapes"):
		print(child.name, " ", child.get_parent().name)
