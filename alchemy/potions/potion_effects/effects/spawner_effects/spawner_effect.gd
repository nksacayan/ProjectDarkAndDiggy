class_name SpawnerEffect
extends PotionEffect


func do_effect(_p_player: PlayerBody, _p_potion: PotionResource, _p_projectile: PackedScene) -> void:
	var projectile: PotionProjectile = _setup_projectile(_p_potion, _p_projectile)
	_set_projectile_position(projectile, _p_player)
	_launch_projectile(_p_player, projectile, _p_potion)

func _setup_projectile(p_potion: PotionResource, p_projectile: PackedScene) -> PotionProjectile:
	var projectile: PotionProjectile = p_projectile.instantiate() as PotionProjectile
	projectile.setup(p_potion)
	projectile.top_level = true
	return projectile

func _set_projectile_position(p_projectile: PotionProjectile, p_player: PlayerBody) -> void:
	const OFFSET := 200
	var flip: int = _get_sign(p_player)
	var calc_offset := OFFSET * flip
	var target_position := p_player.global_position + Vector2(calc_offset, 0)
	p_projectile.global_position = target_position
	p_player.add_child(p_projectile)

func _launch_projectile(p_player: PlayerBody, p_projectile: PotionProjectile, p_potion: PotionResource) -> void:
	var flip: int = _get_sign(p_player)
	p_projectile.apply_impulse(p_potion.vector * Vector2(flip, 1))

func _get_sign(p_player: PlayerBody) -> int:
	if p_player.animation_handler.flip_h == true:
		return -1
	else:
		return 1
