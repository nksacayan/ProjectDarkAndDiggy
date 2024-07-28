class_name PotionResource
extends ItemResource


@export var potion_effect: GDScript
@export var vector: Vector2 = Vector2.ZERO
@export var projectile: PackedScene = null
var player: PlayerBody


func use_potion() -> void:
	if player:
		(potion_effect.new() as PotionEffect).do_effect(player, self, projectile)
		AutoloadQuickInventory.remove_from_inventory(self)
	else:
		push_warning("tried to use potion without player")
