extends Node2D

@export var gravity := Vector2(0, 980)

var velocity := Vector2.ZERO

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _init() -> void:
	set_as_top_level(true)


func _ready() -> void:
	velocity = Vector2(randi_range(-200, 200), -300)


func _process(delta: float) -> void:
	velocity += gravity * delta
	global_position += velocity * delta


func set_damage(dmg: int) -> void:
	if not label:
		await self.ready
	label.text = "-" +  str(dmg)
	animation_player.play("pop")
