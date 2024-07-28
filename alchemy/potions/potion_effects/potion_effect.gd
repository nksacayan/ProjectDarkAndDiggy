class_name PotionEffect
extends GDScript


func do_effect(_p_player: PlayerBody, _p_potion: PotionResource, _p_projectile: PackedScene) -> void:
	if not _p_player:
		push_warning("tried to do_effect without player")
		return
	if not _p_potion:
		push_warning("tried to do_effect without potion")
		return
	print_debug(resource_path)
