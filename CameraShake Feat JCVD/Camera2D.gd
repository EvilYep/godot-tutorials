extends Camera2D

var duration: float
var frequency: float
var amplitude: float

var timer: Timer = Timer.new()
var time_since_last_shake: float = 0.0

func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

func _process(delta: float) -> void:
	if timer.is_stopped():
		return
	
	time_since_last_shake += delta
	
	if time_since_last_shake >= frequency:
		time_since_last_shake = 0.0
		var shake = Vector2(randf_range(-amplitude, amplitude), randf_range(-amplitude, amplitude))
		offset += shake * delta

func start(dur: float, freq: float, ampl: float) -> void:
	duration = dur
	frequency = freq
	amplitude = ampl

	timer.start(duration)

func _on_timer_timeout() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "offset", Vector2.ZERO, duration)
	
