extends State
class_name ChaseState


var enemy : KoboldBody2D
var player: PlayerBody
@onready var hitbox : Area2D = %Hitbox


const _MOVE_SPEED : float = 400.0
const _KOCKBACK_FORCE_X : float = 100000.0
const _KOCKBACK_FORCE_Y : float = -7500
const _DETECT_RANGE : float = 250.0


func enter():
	#Grabs Enemy and Player Nodes
	enemy = get_parent().get_parent()
	if !enemy.player_detect_cast.is_colliding():
		print("Error Target No Player")
	player = enemy.player_detect_cast.get_collider()
	hitbox.get_child(0).disabled = false #hitbox's CollisionShape2d




func physics_update(_delta:float):
	
	enemy.velocity.x = enemy.move_mod * _MOVE_SPEED
	check_direction()
	

#Checks if direction Mod needs to be flipped
func check_direction():
	#Flips direction based on position of player
	if player.global_position.x - enemy.global_position.x < 0 \
		and enemy.move_mod == enemy.MovementModifier.RIGHT:
			flip_direction()
	if player.global_position.x - enemy.global_position.x > 0 \
		and enemy.move_mod == enemy.MovementModifier.LEFT:
			flip_direction()
			
func flip_direction():
	enemy.move_mod *= -1 #flips movement direction
	
	#this might not be needed anymore
	enemy.player_detect_cast.scale = Vector2(enemy.move_mod, 1) 


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
