extends CPUParticles2D
class_name HitParticles

func _ready():
	emitting = true
	await get_tree().create_timer(0.6).timeout
	queue_free()