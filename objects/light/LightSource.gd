extends Area2D

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.play("default")
