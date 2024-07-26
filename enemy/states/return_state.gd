extends State
class_name ReturnState

var enemy : KoboldBody2D
const _MOVE_SPEED : float = 20000.0
const _START_POS_BUFFER : float = 20
@onready var pb_start : Marker2D = %PatrolBoundStart
@onready var hitbox : Area2D = %Hitbox

func enter():
	print("Entering Return State")
	enemy = get_parent().get_parent()
	hitbox.get_child(0).disabled = true
	check_start_dir()

func exit():
	print("Leaving Return State")
		
func physics_update(_delta:float):
	enemy.velocity.x = _MOVE_SPEED * enemy.move_mod * _delta
	if enemy.global_position.x >= pb_start.global_position.x - _START_POS_BUFFER \
		and enemy.global_position.x <= pb_start.global_position.x + _START_POS_BUFFER:
			print(enemy.global_position.x)
			print( pb_start.global_position.x)
			transitioned.emit(self, "PatrolState")
	

func check_start_dir():
	if enemy.global_position.x >= pb_start.global_position.x \
		and enemy.move_mod == enemy.MovementModifier.RIGHT :
		_flip_direction()

	if enemy.global_position.x <= pb_start.global_position.x \
		and enemy.move_mod == enemy.MovementModifier.LEFT :
		_flip_direction()	

func _flip_direction():

	#Flips the sprite, walking direction, 
	#player detection raycast, and floor detection raycast
	enemy.move_mod *= -1
	enemy.player_detect_cast.scale = Vector2(enemy.move_mod, 1)
	enemy.floor_detect_cast.scale = Vector2(enemy.move_mod, 1) 
	
	
