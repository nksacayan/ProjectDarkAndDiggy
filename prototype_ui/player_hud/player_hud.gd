extends CanvasLayer


@onready var armor_image: PanelContainer = %ArmorImage


func _ready() -> void:
	var player: PlayerBody = await _get_player()
	player.earth_armor_activated.connect(_toggle_armor_image)

func _get_player() -> PlayerBody:
	var current_scene = get_tree().current_scene
	await current_scene.ready
	print_debug(current_scene.get_children())
	if current_scene as LevelManager:
		current_scene = current_scene.get_child(0)
	return current_scene.find_child("PlayerBody")

func _toggle_armor_image(armor_enabled: bool) -> void:
	armor_image.visible = armor_enabled

func _on_inventory_button_pressed() -> void:
	var inventory_event: InputEventAction = InputEventAction.new()
	inventory_event.action = "toggle_inventory"
	inventory_event.pressed = true
	Input.parse_input_event(inventory_event)
	#Input.action_press("toggle_inventory")
	print_debug("inventory button pressed")
