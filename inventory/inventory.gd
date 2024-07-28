class_name Inventory
extends Node
## Player inventory
##
## Might wanna change this from an autoload if this project continues after jam
## For now this is specifically an inventory for alchemy ingredients and potions

signal items_updated

@export var items: Array[ItemResource]


func add_to_inventory(p_item: ItemResource) -> void:
	items.append(p_item)
	items_updated.emit()

func remove_from_inventory(p_item: ItemResource) -> void:
	items.erase(p_item)
	items_updated.emit()
