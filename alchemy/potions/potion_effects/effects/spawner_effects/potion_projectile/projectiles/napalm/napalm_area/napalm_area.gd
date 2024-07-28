class_name NapalmArea
extends Area2D


@onready var collision_shape: CollisionShape2D = %CollisionShape2D


func _on_area_entered(area: Area2D) -> void:
	const PLAYER_HURTBOX_LAYER = 6
	const ENEMY_HURTBOX_LAYER = 7
	# if collides with player hurtbox
	if area.get_collision_layer_value(PLAYER_HURTBOX_LAYER):
		_damage_player(area)
	# if collides with enemy hurtbox
	if area.get_collision_layer_value(ENEMY_HURTBOX_LAYER):
		_kill_enemy(area)

func _damage_player(area: Area2D) -> void:
	var player: PlayerBody = area.get_parent() as PlayerBody
	if player:
		player.health.current_health -= 1

func _kill_enemy(p_area: Area2D) -> void:
	p_area.get_parent().queue_free()
