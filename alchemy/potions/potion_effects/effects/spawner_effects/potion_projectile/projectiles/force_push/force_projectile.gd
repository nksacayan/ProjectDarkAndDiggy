extends PotionProjectile

const PLAYER_HURTBOX_LAYER := 6
const ENEMY_HURTBOX_LAYER := 7

@onready var force_area: Area2D = %ForceRadius
@export var push_force: float
@export var vertical_min: float
@export var horizontal_min: float


func _on_hitbox_body_entered(body: Node2D) -> void:
	super._on_hitbox_body_entered(body)
	_apply_force()
	var tilemap_collision: TileMap = body as TileMap
	if tilemap_collision:
		queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	super._on_hitbox_area_entered(area)
	if area.get_collision_layer_value(ENEMY_HURTBOX_LAYER):
		_apply_force()
		queue_free()

func _apply_force() -> void:
	var overlapping_areas: Array[Area2D] = force_area.get_overlapping_areas()
	for area in overlapping_areas:
		if area.get_collision_layer_value(ENEMY_HURTBOX_LAYER):
			var enemy: KoboldBody2D = area.get_parent() as KoboldBody2D
			enemy.stun_timer.start()
			enemy.knockback_force = _get_force_vector(enemy, force_area)
		if area.get_collision_layer_value(PLAYER_HURTBOX_LAYER):
			var player: PlayerBody = area.get_parent() as PlayerBody
			player.stun_timer.start()
			player.knockback_force = _get_force_vector(player, force_area)

# there is a bug where sometimes this function doesn't run and I don't know why
func _get_force_vector(body: CharacterBody2D, area: Area2D) -> Vector2:
	var direction: Vector2 = area.global_position.direction_to(body.global_position)
	var push_vector: Vector2 = direction * push_force
	push_vector.y = min(push_vector.y, vertical_min)
	if push_vector.x > 0:
		push_vector.x = max(push_vector.x, horizontal_min)
	elif push_vector.x < 0:
		push_vector.x = min(push_vector.x, -horizontal_min)
	return push_vector


