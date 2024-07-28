extends PotionProjectile


func _on_hitbox_body_entered(body: Node2D) -> void:
	super._on_hitbox_body_entered(body)
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	const ENEMY_HURTBOX_LAYER := 7
	super._on_hitbox_area_entered(area)
	if area.get_collision_layer_value(ENEMY_HURTBOX_LAYER):
		area.get_parent().queue_free()
		queue_free()

