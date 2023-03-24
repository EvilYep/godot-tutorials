extends CanvasLayer

onready var ability_icon: TextureProgress = $AbilityIcon
onready var tween: Tween = $Tween

func recharge_active_ability(time: float) -> void:
	var __ = tween.interpolate_property(ability_icon, "value", 100, 0, time)
	assert(__)
	__ = tween.start()
	assert(__)
