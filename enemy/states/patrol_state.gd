extends State
class_name PatrolState


const _LIGHT_COLLISON_LAYER : int = 8
const _SMOKE_COLLISON_LAYER : int = 5
const _DISTRACT_COLLISION_LAYER : int  = 10

const _MOVE_SPEED : float = 20000.0
const _DETECT_RANGE : float = 250.0

var target #Assume Area2D. Can be PlayerBody or DistractionOBJ

func enter(_target) -> void:
	enemy = get_parent().get_parent()


func exit():
	target = null

func physics_update(_delta:float):
	if !enemy:
		print_debug("Error No Enemy Unit for Physics")
		return 0
	check_player()
	check_player_far()
	check_bounds()

func check_player_far() -> void :
	if !enemy.light_detect_cast.is_colliding():
		return 

	for collision in enemy.light_detect_cast.collision_result:
		var area : Area2D = collision.get("collider")
		
		#smoke detection
		if area.get_collision_layer_value(_SMOKE_COLLISON_LAYER):
			return 

		if area.get_collision_layer_value(_DISTRACT_COLLISION_LAYER):
			if target == null:
				target = area
			if(_check_los()):
				transition_chase()
			
		#light detection
		if area.get_collision_layer_value(_LIGHT_COLLISON_LAYER):

			if !area.has_overlapping_bodies():
				return
				
			if target == null:
				target = area.get_overlapping_bodies()[0]
			
			if(_check_los()):
				transition_chase()


#checks for target in range using raycast
func check_player():
	if enemy.player_detect_cast.is_colliding():
		if enemy.player_detect_cast.get_collider(0) is PlayerBody :
			if target == null:
				target = enemy.player_detect_cast.get_collider(0)
			if !_check_los():
				return
			transition_chase()

func transition_chase():
	print_debug("target detected.")
	transitioned.emit(self, "ChaseState", target)
	
func _check_los() -> bool:
	los.target_position = los.to_local(target.global_position)
	return (los.get_collider() is PlayerBody) or \
		(los.get_collider() is Area2D)

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
	#target detection raycast, and floor detection raycast
	enemy.move_mod = ( prev_move * -1 ) as KoboldBody2D.MovementModifier
	enemy.player_detect_cast.scale = Vector2(enemy.move_mod, 1)
	enemy.floor_detect_cast.scale = Vector2(enemy.move_mod, 1) 
	enemy.light_detect_cast.scale = Vector2(enemy.move_mod, 1)
	light_beam.scale = Vector2(LIGHTBEAM_SCALE_X, enemy.move_mod * LIGHTBEAM_SCALE_Y)

