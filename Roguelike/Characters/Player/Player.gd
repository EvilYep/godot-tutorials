extends Character
class_name Player

var mouse_direction := Vector2.ZERO

#### ACCESSORS ####

func is_class(value: String): return value == "Player" or .is_class(value)
func get_class() -> String: return "Player"

#### BUILT-IN ####

func _process(_delta: float) -> void:
	mouse_direction = (get_global_mouse_position() - global_position).normalized()
	animated_sprite.flip_h = mouse_direction.x < 0
	
#### LOGIC ####

func get_input() -> void:
	mov_direction = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
