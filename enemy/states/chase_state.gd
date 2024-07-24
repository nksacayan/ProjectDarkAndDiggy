extends State
class_name ChaseState

var player: CharacterBody2D
@export var enemy: KoboldBody2D
const _MOVE_SPEED : float = 500.0
const _DETECT_RANGE : float = 250.0

func enter():
	player = get_tree().get_first_node_in_group("Player")
	

func exit():
	pass
	
func update(_delta:float):
	pass
	
func physics_update(_delta:float):
	
	enemy.velocity.x = enemy.move_mod * _MOVE_SPEED
	
	if player.global_position.x - enemy.global_position.x < 0 \
		and enemy.move_mod == enemy.MovementModifier.RIGHT:
			flip_direction()
	if player.global_position.x - enemy.global_position.x > 0 \
		and enemy.move_mod == enemy.MovementModifier.LEFT:
			flip_direction()
			
func flip_direction(): 
	enemy.sprite2D.flip_h = not enemy.sprite2D.flip_h #flips Sprite
	enemy.move_mod *= -1 #flips movement direction
	enemy.player_detect_cast.target_position = Vector2(_DETECT_RANGE * enemy.move_mod,0) #Flips Raycast
	
