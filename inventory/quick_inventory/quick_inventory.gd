class_name QuickInventory
extends Inventory


var level_manager: LevelManager
var player: PlayerBody


func _ready() -> void:
	await _setup_level_manager()
	level_manager.next_level_transitioned.connect(_run_per_level_setup)

func _run_per_level_setup() -> void:
	await _setup_player()
	_push_player_to_potions()

func _setup_level_manager() -> void:
	level_manager = await _get_level_manager()
	if not level_manager:
		push_warning("Quick inventory failed to get manager")

func _get_level_manager() -> LevelManager:
	var current_scene = get_tree().current_scene
	await current_scene.ready
	if current_scene as LevelManager:
		return current_scene
	else:
		push_error("failed to get level manager")
		return null

func _setup_player() -> void:
	player = await _get_player()
	if not player:
		push_warning("Quick inventory failed to get player")

func _get_player() -> PlayerBody:
	if level_manager:
		var children: Array[Node] = level_manager.get_children()
		for child in children:
			print_debug(child.name)
		var level: Node2D = children.back()
		var returned_player: PlayerBody = level.find_child("PlayerBody")
		return returned_player
	else: # should only be used for testing
		var current_scene = get_tree().current_scene
		await current_scene.ready
		print_debug(current_scene.get_children())
		if current_scene as LevelManager:
			current_scene = current_scene.get_child(0)
		return current_scene.find_child("PlayerBody")

func add_to_inventory(p_item: ItemResource) -> bool:
	if super.add_to_inventory(p_item):
		var potion: PotionResource = p_item as PotionResource
		if potion and player:
			potion.player = player
		elif not player:
			push_warning("Added to quick inventory without player")
		return true
	return false

func _push_player_to_potions() -> void:
	for potion: PotionResource in items:
		potion.player = player
