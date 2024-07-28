extends PotionProjectile


func _on_timer_timeout() -> void:
	queue_free()
