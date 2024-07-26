class_name ItemCard
extends PanelContainer


signal clicked(p_item_card: ItemCard)

@export var item: ItemResource

@onready var texture_rect: TextureRect = %TextureRect


func _ready() -> void:
	texture_rect.texture = item.texture2d

func _on_gui_input(event: InputEvent) -> void:
	var mouse_event: InputEventMouseButton = event as InputEventMouseButton
	if mouse_event and mouse_event.pressed:
		clicked.emit(self as ItemCard)
