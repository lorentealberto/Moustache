extends AnimatedSprite2D

@onready var timer: Timer = $Timer
@onready var attacks: Node = $Attacks


const MIN_ATTACK_TIME: float = 3
const MAX_ATTACK_TIME: float = 7
const MIN_DELAY: float = 1
const MAX_DELAY: float = 3


var attack_id: int = -1
var last_attack: int = -1

func _ready() -> void:
	Signals.game_started.connect(set_attack_timer)


func _process(delta: float) -> void:
	if not timer.is_stopped():
		attacks.get_child(attack_id).execute()


func set_attack_timer() -> void:
	timer.start(randf_range(MIN_ATTACK_TIME, MAX_ATTACK_TIME))
	
	attack_id = randi() % attacks.get_child_count()


func _on_timer_timeout() -> void:
	attack_id = -1
	await get_tree().create_timer(randf_range(MIN_DELAY, MAX_DELAY)).timeout
	set_attack_timer()
