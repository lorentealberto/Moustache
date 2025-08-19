extends GPUParticles2D

func _ready() -> void:
	finished.connect(destroy)
	emitting = true
	
	if get_child_count() > 0: 
		$Core.emitting = true

func destroy() -> void:
	queue_free()
