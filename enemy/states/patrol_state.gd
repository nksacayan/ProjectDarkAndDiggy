extends State
class_name PatrolState


@export var enemy: KoboldBody2D
@export var move_speed : float = 500.0

	

func physics_update(_delta:float):
	if enemy:
		enemy.velocity.x = move_speed * enemy.move_mod
		if enemy.global_position.x >= enemy.pb_right.global_position.x \
			and enemy.move_mod == enemy.MovementModifier.RIGHT :
			enemy._flip_direction()
		if enemy.global_position.x <= enemy.pb_left.global_position.x \
			and enemy.move_mod == enemy.MovementModifier.LEFT :
			enemy._flip_direction()





