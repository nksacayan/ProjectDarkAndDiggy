class_name Potion
extends RefCounted

@export var potion_resource: PotionResource

func use_potion() -> void:
	print_debug("Use potion")
	(potion_resource.potion_script as PotionScript).do_effect()
	pass
