extends PotionEffect


func do_effect(_p_player: PlayerBody, _p_potion: PotionResource, _p_projectile: PackedScene) -> void:
	_p_player.timer.start()
	_p_player.knockback_force = _p_potion.vector
	print_debug(_p_player.velocity)
	print_debug(resource_path)

