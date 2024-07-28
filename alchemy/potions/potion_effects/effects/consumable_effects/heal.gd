extends PotionEffect


func do_effect(_p_player: PlayerBody, _p_potion: PotionResource, _p_projectile: PackedScene) -> void:
	_p_player.health.current_health += 1
	print_debug(resource_path)

