extends PotionProjectile


@export var explosion_scene: PackedScene


func _on_timer_timeout() -> void:
	_spawn_explosion()
	queue_free()

func _spawn_explosion() -> void:
	var explosion: Explosion = explosion_scene.instantiate() as Explosion
	explosion.top_level = true
	explosion.global_position = global_position
	get_parent().add_child(explosion)
