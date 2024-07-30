extends Area2D


@onready var _timer: Timer = %Timer
@onready var _animation: AnimatedSprite2D = %AnimatedSprite2D


func _on_animated_sprite_2d_animation_finished() -> void:
	if _animation.animation == "buildup":
		_animation.play("tension")
	elif _animation.animation == "disperse":
		queue_free()

func _on_animated_sprite_2d_animation_looped() -> void:
	if _timer.is_stopped():
		_animation.play("disperse")
