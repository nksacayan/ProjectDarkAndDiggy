extends VBoxContainer

@export var item_card_scene: PackedScene
var item_cards: Array[ItemCard]
@onready var item_grid: GridContainer = %GridContainer


func _ready() -> void:
	AutoloadInventory.items_updated.connect(_update_item_cards)
	_clear_item_cards()
	_update_item_cards()

func _update_item_cards() -> void:
	_clear_item_cards()
	var num_filled_cards: int = 0
	for item: ItemResource in AutoloadInventory.items:
		var item_card: ItemCard = item_card_scene.instantiate() as ItemCard
		item_card.item = item
		item_card.clicked.connect(_on_item_clicked)
		item_grid.add_child(item_card)
		num_filled_cards += 1
	while num_filled_cards < AutoloadInventory.max_items:
		# add dummy card
		var item_card: ItemCard = item_card_scene.instantiate() as ItemCard
		item_grid.add_child(item_card)
		num_filled_cards += 1

func _clear_item_cards() -> void:
	for item in item_grid.get_children():
		item.queue_free()

func _on_item_clicked(p_item_card: ItemCard) -> void:
	if p_item_card.item is IngredientResource:
		var add_successful: bool = AutoloadMixer.add_ingredient(p_item_card.item)
		if add_successful:
			AutoloadInventory.remove_from_inventory(p_item_card.item)
	elif p_item_card.item is PotionResource:
		var add_successful: bool = AutoloadQuickInventory.add_to_inventory(p_item_card.item)
		if add_successful:
			AutoloadInventory.remove_from_inventory(p_item_card.item)
	else:
		push_warning("undefined item")
