extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Signals.barber_appeared.connect(show_background)

func show_background() -> void:
	anim.play("fade in")
