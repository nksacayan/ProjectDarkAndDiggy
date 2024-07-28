extends PotionProjectile


@export var smoke_scene: PackedScene


func _on_hitbox_body_entered(body: Node2D) -> void:
	var tilemap_collision: TileMap = body as TileMap
	if tilemap_collision:
		_spawn_smoke(body)
	queue_free()

func _spawn_smoke(body: Node2D) -> void:
	var smoke_area := smoke_scene.instantiate() as Node2D
	smoke_area.global_position = global_position
	# engine why you bitching
	body.call_deferred("add_child", smoke_area)
	

