extends CanvasLayer


@onready var armor_image: PanelContainer = %ArmorImage
@onready var button: TextureButton = %InventoryButton
@export var backpack_texture: Texture2D
@export var return_texture: Texture2D


func _ready() -> void:
	var player: PlayerBody = _get_player()
	player.earth_armor_activated.connect(_toggle_armor_image)

func _get_player() -> PlayerBody:
	return get_parent()

func _toggle_armor_image(armor_enabled: bool) -> void:
	armor_image.visible = armor_enabled

func _on_inventory_button_pressed() -> void:
	var inventory_event: InputEventAction = InputEventAction.new()
	inventory_event.action = "toggle_inventory"
	inventory_event.pressed = true
	Input.parse_input_event(inventory_event)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		_switch_button_image()

func _switch_button_image() -> void:
	match button.texture_normal:
		backpack_texture:
			_set_all_button_images(return_texture)
		return_texture:
			_set_all_button_images(backpack_texture)
		_:
			push_warning("fucked up inventory button")

func _set_all_button_images(texture: Texture2D) -> void:
	button.texture_normal = texture
	button.texture_pressed = texture
	button.texture_hover = texture




