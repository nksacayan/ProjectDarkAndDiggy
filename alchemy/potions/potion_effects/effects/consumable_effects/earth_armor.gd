extends PotionEffect


func do_effect(_p_player: PlayerBody, _p_potion: PotionResource, _p_projectile: PackedScene) -> void:
	_p_player.armor_flag = true
