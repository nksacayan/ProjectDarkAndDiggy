class_name QuickInventory
extends Inventory

var player: PlayerBody

func _ready() -> void:
	player = await _get_player()
	if not player:
		push_warning("Quick inventory failed to get player")
	_push_player_to_potions()

func _get_player() -> PlayerBody:
	var current_scene = get_tree().current_scene
	await current_scene.ready
	return current_scene.find_child("PlayerBody")

func add_to_inventory(p_item: ItemResource) -> void:
	super.add_to_inventory(p_item)
	var potion: PotionResource = p_item as PotionResource
	if potion and player:
		potion.player = player
	elif not player:
		push_warning("Added to quick inventory without player")

func _push_player_to_potions() -> void:
	for potion: PotionResource in items:
		potion.player = player
