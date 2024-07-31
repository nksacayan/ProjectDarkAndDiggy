class_name Collectable
extends Node2D
## Something that can be collected to the inventory

## Collectable must have an item resource
@export var item: ItemResource

@onready var sprite: Sprite2D = %Sprite2D
@onready var collision_shape: CollisionShape2D = %CollisionShape2D


func _ready() -> void:
	_setup_sprite()
	
func _on_area_2d_body_entered(_body: Node2D) -> void:
	if item as PotionResource and AutoloadQuickInventory.add_to_inventory(item):
		queue_free()
		return
	AutoloadInventory.add_to_inventory(item)
	queue_free()

func _setup_sprite() -> void:
	if not item:
		push_warning(name + " has empty ingredient type.")
		return
	_scale_sprite()

func _scale_sprite() -> void:
	sprite.texture = item.texture2d
	# auto scale the sprite up to the size of the collision shape
	var sprite_size: Vector2 = sprite.texture.get_size()
	var collision_shape_size: Vector2 = collision_shape.shape.get_rect().size
	if sprite_size != collision_shape_size:
		sprite.scale.x = collision_shape_size.x / sprite_size.x
		sprite.scale.y = collision_shape_size.y / sprite_size.y
