extends CanvasLayer

const MIN_HEALTH := 23 # offfset at which we begin to see the bar in pixels. The 0 of the 'over' sprite

var max_hp := 4

onready var player: KinematicBody2D = get_parent().get_node("Player")
onready var health_bar: TextureProgress = $HealthBar
onready var health_bar_tween: Tween = $HealthBar/Tween

func _ready() -> void:
	max_hp = player.max_hp
	_update_health_bar(100)

func _update_health_bar(new_value:int) -> void:
	var __ = health_bar_tween.interpolate_property(health_bar, "value", health_bar.value, new_value, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	__ = health_bar_tween.start()

func _on_Player_health_changed(new_hp: int) -> void:
	var new_health: int = int((100 - MIN_HEALTH) * float(new_hp) / max_hp) + MIN_HEALTH
	_update_health_bar(new_health)
