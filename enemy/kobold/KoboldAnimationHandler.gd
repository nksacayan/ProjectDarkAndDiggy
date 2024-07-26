class_name KoboldAnimationHandler
extends AnimatedSprite2D


func _face_left_right(p_left_right: float) -> void:
	# flip_h == false means sprite facing right
	# offset should be configured in the node, just flip it here
	if p_left_right > 0:
		flip_h = false
		offset = abs(offset)
	elif p_left_right < 0:
		flip_h = true
		offset = -abs(offset)

func handle_animation(p_velocity: Vector2) -> void:
	if p_velocity.x != 0:
		play("walk")
	else:
		play("idle")
	
	_face_left_right(p_velocity.x)
