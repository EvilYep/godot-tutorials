extends KinematicBody2D
class_name Character, "res://Assets/knight_icon.png"

const HIT_FX_SCENE := preload("res://FX/HitEffect.tscn")

const FRICTION := 0.15

export(int) var health := 2 setget set_health
export(int) var max_hp := 2
signal health_changed(new_hp)

export(int) var acceleration := 40
export(int) var max_speed := 100

export(bool) var flying := false

onready var state_machine: Node = get_node("StateMachine")
onready var animated_sprite: AnimatedSprite = $AnimatedSprite

var mov_direction := Vector2.ZERO
var velocity := Vector2.ZERO 

#### ACCESSORS ####

func is_class(value: String): return value == "Character" or .is_class(value)
func get_class() -> String: return "Character"

func set_health(new_hp: int) -> void:
	health = clamp(new_hp, 0, max_hp)
	emit_signal("health_changed", health)

#### BUILT-IN ####

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

#### LOGIC ####

func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * acceleration
	velocity = velocity.limit_length(max_speed)

func take_damage(damage: int, knockback_direction: Vector2, knockback_force: int) -> void:
	if state_machine.state != state_machine.states.hurt and state_machine.state != state_machine.states.dead:
		_spawn_hit_fx()
		self.health -= damage
		
		if name == "Player":
			SavedData.hp = health
		
		if health > 0:
			state_machine.set_state(state_machine.states.hurt)
			velocity += knockback_direction * knockback_force
		else:
			state_machine.set_state(state_machine.states.dead)
			velocity += knockback_direction * knockback_force * 2

func _spawn_hit_fx() -> void:
	var hit_fx = HIT_FX_SCENE.instance()
	add_child(hit_fx)
