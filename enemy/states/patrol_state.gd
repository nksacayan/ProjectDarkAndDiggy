extends State
class_name PatrolState

@export var enemy: KoboldBody2D
#Marker2D for Patrol Bounds and Start position
@onready var pb_right : Marker2D = %PatrolBoundRight
@onready var pb_left : Marker2D = %PatrolBoundLeft
@onready var pb_start : Marker2D = %PatrolBoundStart


const _MOVE_SPEED : float = 250.0
const _DETECT_RANGE : float = 250.0


func physics_update(_delta:float):
	if enemy:
		check_player() 
		enemy.velocity.x = _MOVE_SPEED * enemy.move_mod
		check_bounds()

#checks for player in range using raycast
func check_player():
	if enemy.player_detect_cast.is_colliding():
		print("Player detected. Switching to chase state")
		transitioned.emit(self, "ChaseState")


#check if unit has read its patrol bound 
#if so, flips direction
func check_bounds():
	if enemy.global_position.x >= pb_right.global_position.x \
		and enemy.move_mod == enemy.MovementModifier.RIGHT :
		_flip_direction()



	if enemy.global_position.x <= pb_left.global_position.x \
		and enemy.move_mod == enemy.MovementModifier.LEFT :
		_flip_direction()	


func _flip_direction(): 
	var prev_move = enemy.move_mod
	enemy.move_mod = enemy.MovementModifier.CENTER #pauses movement
	await get_tree().create_timer(2).timeout #Duration of paused movement
	
	enemy.sprite2D.flip_h = not enemy.sprite2D.flip_h #flips Sprite
	enemy.move_mod = prev_move * -1 #flips movement direction
	enemy.player_detect_cast.target_position = \
		Vector2(_DETECT_RANGE * enemy.move_mod,0) #Flips Raycast
	


