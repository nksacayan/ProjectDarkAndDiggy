extends State
class_name ChaseState

var player: CharacterBody2D
@export var enemy: KoboldBody2D
@export var move_speed : float = 500.0

func enter():
	player = get_tree().get_first_node_in_group("Player")
	

func exit():
	pass
	
func update(_delta:float):
	pass
	
func physics_update(_delta:float):
	
	enemy.velocity.x = enemy.move_mod * move_speed
	
	if player.global_position.x - enemy.global_position.x < 0 \
		and enemy.move_mod == enemy.MovementModifier.RIGHT:
			enemy._flip_direction()
	if player.global_position.x - enemy.global_position.x > 0 \
		and enemy.move_mod == enemy.MovementModifier.LEFT:
			enemy._flip_direction()
