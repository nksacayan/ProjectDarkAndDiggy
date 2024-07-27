extends State
class_name ChaseState

const _MOVE_SPEED : float = 40000.0
const _KOCKBACK_FORCE_X : float = 100000.0
const _KOCKBACK_FORCE_Y : float = -7500
const _DETECT_RANGE : float = 250.0

var los_count : int = 0
var player : PlayerBody

func enter(p_player : PlayerBody):
	print("Entering Chase State")
	#Grabs Enemy and Player Nodes
	hitbox.get_child(0).disabled = false #hitbox's CollisionShape2d
	player = p_player


func exit():
	print("Leaving Chase State")
	player = null

func physics_update(_delta:float):
	
	enemy.velocity.x = _MOVE_SPEED * enemy.move_mod * _delta
	check_direction()
	check_los()
	

#Checks if direction Mod needs to be flipped
func check_direction():
	#Flips direction based on position of player
	if player.global_position.x - enemy.global_position.x < 0 \
		and enemy.move_mod == enemy.MovementModifier.RIGHT:
			flip_direction()
	if player.global_position.x - enemy.global_position.x > 0 \
		and enemy.move_mod == enemy.MovementModifier.LEFT:
			flip_direction()

#TODO funciton to check LoS with Player and switch states if needed

func check_los():
	los.target_position = los.to_local(player.global_position)
	if !(los.get_collider() is PlayerBody):
		los_count += 1
		if los_count == 60:
			transitioned.emit(self, "ReturnState", null)
	else:
		los_count =0

func flip_direction():
	enemy.move_mod = (enemy.move_mod * -1) as KoboldBody2D.MovementModifier
	#flips movement direction
	
	#this might not be needed anymore
	enemy.player_detect_cast.scale = Vector2(enemy.move_mod, 1) 
	enemy.light_detect_cast.scale = Vector2(enemy.move_mod, 1) 


#TODO - Damage Logic here
func target_hit():
	print("Enemy Hit Player")
	player.health.current_health -= 1
	print("Current HP: " , player.health.current_health) 
	apply_knockback()
	
	
func apply_knockback():
	player.knockback_force = Vector2(_KOCKBACK_FORCE_X * enemy.move_mod , \
		_KOCKBACK_FORCE_Y)
	player.timer.start()

func _on_hitbox_area_entered(_area):
	target_hit()
