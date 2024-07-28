class_name PotionProjectile
extends RigidBody2D


var potion_resource: PotionResource = null
@onready var sprite: Sprite2D = %Sprite2D
@onready var collision_shape: CollisionShape2D = %CollisionShape2D
@onready var hitbox_shape: CollisionShape2D = %HitboxShape


func _ready() -> void:
	_setup_sprite()
	_setup_hitbox()

func _setup_sprite() -> void:
	if not potion_resource:
		push_warning(name + " has empty potion type.")
		return
	sprite.texture = potion_resource.texture2d
	_scale_sprite()

func _scale_sprite() -> void:
	sprite.texture = potion_resource.texture2d
	# auto scale the sprite up to the size of the collision shape
	var sprite_size: Vector2 = sprite.texture.get_size()
	var collision_shape_size: Vector2 = collision_shape.shape.get_rect().size
	if sprite_size != collision_shape_size:
		sprite.scale.x = collision_shape_size.x / sprite_size.x
		sprite.scale.y = collision_shape_size.y / sprite_size.y

func _setup_hitbox() -> void:
	var collision_shape_size: Vector2 = (collision_shape.shape as RectangleShape2D).size
	(hitbox_shape.shape as RectangleShape2D).size = collision_shape_size * 1.1

func setup(p_potion_resource: PotionResource) -> void:
	potion_resource = p_potion_resource

func _on_hitbox_body_entered(body: Node2D) -> void:
	print_debug(body)
	# for tilemap collision

func _on_hitbox_area_entered(area: Area2D) -> void:
	print_debug(area)
	# for player/enemy hurtbox collision
