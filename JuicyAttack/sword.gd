extends Node2D

var mouse_pos: Vector2

@onready var pivot: Marker2D = $Pivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shadow: Sprite2D = $Shadow
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func attack() -> void:
	audio_stream_player.pitch_scale = randf_range(1.7, 2.6)
	animation_player.play("slash")

func _physics_process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	
	pivot.look_at(mouse_pos)
	
	# Float
	pivot.position.y = sin(Time.get_ticks_msec() * delta * 0.20) * 10
	
	pivot.scale.y =  -1 if mouse_pos.x - global_position.x < 0 else 1

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attack()
