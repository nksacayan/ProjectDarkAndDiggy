extends PanelContainer


@export var item_card_scene: PackedScene
var item_cards: Array[ItemCard]
@onready var item_row: HBoxContainer = %HBoxContainer


func _ready() -> void:
	AutoloadQuickInventory.items_updated.connect(_update_item_cards)
	_clear_item_cards()
	_update_item_cards()

func _update_item_cards() -> void:
	_clear_item_cards()
	var num_filled_cards: int = 0
	for item: ItemResource in AutoloadQuickInventory.items:
		var item_card: ItemCard = item_card_scene.instantiate() as ItemCard
		item_card.item = item
		item_card.clicked.connect(_on_item_clicked)
		item_row.add_child(item_card)
		num_filled_cards += 1
	while num_filled_cards < AutoloadQuickInventory.max_items:
		# add dummy card
		var item_card: ItemCard = item_card_scene.instantiate() as ItemCard
		item_row.add_child(item_card)
		num_filled_cards += 1
	

func _clear_item_cards() -> void:
	for item in item_row.get_children():
		item.queue_free()

func _on_item_clicked(p_item_card: ItemCard) -> void:
	var item: ItemResource = p_item_card.item
	if AutoloadInventoryAlchemyView.visible:
		# if inventory UI is open, clicks move item to inventory
		AutoloadInventory.add_to_inventory(item)
		AutoloadQuickInventory.remove_from_inventory(item)
	else:
		# if inventory ui is closed, clicks use the item
		var potion: PotionResource = item as PotionResource
		if potion:
			potion.use_potion()
