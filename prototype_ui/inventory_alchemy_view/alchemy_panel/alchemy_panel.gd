class_name AlchemyPanel
extends VBoxContainer


@export var item_card_scene: PackedScene
@export var grey_theme: StyleBoxTexture
@export var white_theme: StyleBoxTexture

@onready var _left_ingredient_panel: PanelContainer = %LeftIngredientPanel
@onready var _right_ingredient_panel: PanelContainer = %RightIngredientPanel
@onready var _potion_panel: PanelContainer = %PotionPanel


func _ready() -> void:
	AutoloadMixer.ingredients_updated.connect(_update_ingredient_panels)
	AutoloadMixer.potion_updated.connect(_update_potion_panel)

func _update_ingredient_panels() -> void:
	_clear_panel_children(_left_ingredient_panel)
	_clear_panel_children(_right_ingredient_panel)
	_add_item_card(_left_ingredient_panel, AutoloadMixer._left_ingredient, white_theme)
	_add_item_card(_right_ingredient_panel, AutoloadMixer._right_ingredient, white_theme)

func _clear_panel_children(p_panel_container: PanelContainer) -> void:
	for items in p_panel_container.get_children():
		items.queue_free()

func _update_potion_panel() -> void:
	_clear_panel_children(_potion_panel)
	_add_item_card(_potion_panel, AutoloadMixer.potion_result, grey_theme)

func _on_button_pressed() -> void:
	AutoloadMixer.mix()

func _on_item_clicked(p_item_card: ItemCard) -> void:
	var card_parent: PanelContainer = p_item_card.get_parent_control() as PanelContainer
	if card_parent in [_left_ingredient_panel, _right_ingredient_panel]:
		AutoloadInventory.add_to_inventory(p_item_card.item)
		AutoloadMixer.remove_ingredient(p_item_card.item)
	elif card_parent == _potion_panel:
		AutoloadInventory.add_to_inventory(p_item_card.item)
		AutoloadMixer.potion_result = null

func _add_item_card(p_parent_panel: PanelContainer, p_ingredient: ItemResource, \
	p_theme: StyleBoxTexture) -> void:
	var item_card: ItemCard = item_card_scene.instantiate() as ItemCard
	item_card.add_theme_stylebox_override("panel", p_theme)
	if p_ingredient:
		item_card.item = p_ingredient
		item_card.clicked.connect(_on_item_clicked)
	p_parent_panel.add_child(item_card)
