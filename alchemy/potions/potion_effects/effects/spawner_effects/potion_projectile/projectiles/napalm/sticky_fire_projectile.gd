extends PotionProjectile


@export var napalm_area_scene: PackedScene


# hitbox must be both monitoring and monitorable to notice tilemap fuck me
func _on_hitbox_body_entered(body: Node2D) -> void:
	var tilemap_collision: TileMap = body as TileMap
	if tilemap_collision:
		_spawn_napalm_area(body)
	queue_free()

func _spawn_napalm_area(body: Node2D) -> void:
	var napalm_area: NapalmArea = napalm_area_scene.instantiate() as NapalmArea
	napalm_area.global_position = global_position
	# engine why you bitching
	body.call_deferred("add_child", napalm_area)
	
