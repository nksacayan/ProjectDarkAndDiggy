extends State
class_name PatrolState

var enemy: KoboldBody2D
#Marker2D for Patrol Bounds and Start position
@onready var pb_right : Marker2D = %PatrolBoundRight
@onready var pb_left : Marker2D = %PatrolBoundLeft



const _MOVE_SPEED : float = 20000.0
const _DETECT_RANGE : float = 250.0

func enter():
	print("Entering Patrol State")
	enemy = get_parent().get_parent()

func exit():
	print("leaving Patrol State")

func physics_update(_delta:float):
	if !enemy:
		print("Error No Enemy Unit for Physics")
		return 0
	

	check_player() 
	check_bounds()
	enemy.velocity.x = _MOVE_SPEED * enemy.move_mod * _delta


#checks for player in range using raycast
func check_player():
	if enemy.player_detect_cast.is_colliding():
		print(enemy.player_detect_cast.get_collider())
		if enemy.player_detect_cast.get_collider() is PlayerBody :
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
	
	#Flips the sprite, walking direction, 
	#player detection raycast, and floor detection raycast
	enemy.move_mod = prev_move * -1
	enemy.player_detect_cast.scale = Vector2(enemy.move_mod, 1)
	enemy.floor_detect_cast.scale = Vector2(enemy.move_mod, 1) 
	
	


