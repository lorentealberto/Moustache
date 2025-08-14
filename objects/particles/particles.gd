extends GPUParticles2D

func _ready() -> void:
	finished.connect(destroy)
	emitting = true

func destroy() -> void:
	queue_free()
