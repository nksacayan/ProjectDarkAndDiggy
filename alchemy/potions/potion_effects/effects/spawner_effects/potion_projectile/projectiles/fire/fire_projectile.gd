extends PotionProjectile


@export var animation: PackedScene


func _on_hitbox_body_entered(body: Node2D) -> void:
	super._on_hitbox_body_entered(body)
	var tilemap_collision: TileMap = body as TileMap
	if tilemap_collision:
		_burst()

func _on_hitbox_area_entered(area: Area2D) -> void:
	const ENEMY_HURTBOX_LAYER := 7
	super._on_hitbox_area_entered(area)
	if area.get_collision_layer_value(ENEMY_HURTBOX_LAYER):
		area.get_parent().queue_free()
		_burst()

func _burst() -> void:
	var animation_node: AnimatedSprite2D = animation.instantiate() as AnimatedSprite2D
	get_parent().add_child(animation_node)
	animation_node.top_level = true
	animation_node.global_position = global_position
	queue_free()
