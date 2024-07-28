extends State
class_name ReturnState

const _MOVE_SPEED : float = 60000.0
const _START_POS_BUFFER : float = 20

func enter(_player : Area2D):
	enemy = get_parent().get_parent()
	hitbox.get_child(0).disabled = true
	check_start_dir()



func physics_update(_delta:float):
	if enemy.global_position.x >= pb_start.global_position.x - _START_POS_BUFFER \
		and enemy.global_position.x <= pb_start.global_position.x + _START_POS_BUFFER:
			transitioned.emit(self, "PatrolState", null)
	

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
	enemy.move_mod = (enemy.move_mod * -1) as KoboldBody2D.MovementModifier
	enemy.player_detect_cast.scale = Vector2(enemy.move_mod, 1)
	enemy.floor_detect_cast.scale = Vector2(enemy.move_mod, 1)
	enemy.light_detect_cast.scale = Vector2(enemy.move_mod , 1)
	light_beam.scale = Vector2(LIGHTBEAM_SCALE_X, enemy.move_mod * LIGHTBEAM_SCALE_Y)
	
	
