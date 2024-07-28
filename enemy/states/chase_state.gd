extends State
class_name ChaseState

const _MOVE_SPEED : float = 40000.0
const _KOCKBACK_FORCE_X : float = 100000.0
const _KOCKBACK_FORCE_Y : float = -7500
const _DETECT_RANGE : float = 250.0

var los_count : int = 0
var target #Assume Area2D. Can be PlayerBody or DistractionOBJ

func enter(p_target) -> void:
	#Grabs Enemy and target Nodes
	hitbox.get_child(0).disabled = false #hitbox's CollisionShape2d
	target = p_target


func exit() -> void:
	target = null

func physics_update(_delta:float) -> void:
	if target == null:
		leave_state()
		return
	check_direction()
	check_los()
	

#Checks if direction Mod needs to be flipped
func check_direction() -> void:
	#Flips direction based on position of target
	if target.global_position.x - enemy.global_position.x < 0 \
		and enemy.move_mod == enemy.MovementModifier.RIGHT:
			flip_direction()
	if target.global_position.x - enemy.global_position.x > 0 \
		and enemy.move_mod == enemy.MovementModifier.LEFT:
			flip_direction()


func check_los() -> void:
	los.target_position = los.to_local(target.global_position)
	if !(los.get_collider() is PlayerBody):
		los_count += 1
		if los_count == 60:
			leave_state()
	else:
		los_count =0

func leave_state() -> void:
	transitioned.emit(self, "ReturnState", null)
	
func flip_direction() -> void:
	enemy.move_mod = (enemy.move_mod * -1) as KoboldBody2D.MovementModifier
	#flips movement direction
	
	#this might not be needed anymore
	enemy.player_detect_cast.scale = Vector2(enemy.move_mod, 1) 
	enemy.light_detect_cast.scale = Vector2(enemy.move_mod, 1) 
	light_beam.scale = Vector2(LIGHTBEAM_SCALE_X, enemy.move_mod * LIGHTBEAM_SCALE_Y)



func target_hit() -> void:
	if ! target is PlayerBody:
		return
	if target.armor_flag:
		return
	apply_knockback()
	target.health.current_health -= 1

#theorectially if this run target should only be PlayerBody? I hope ;-;
func apply_knockback() -> void:
	if !target is PlayerBody:
		print_debug("Target not PlayerBody")
		return
	
	target.knockback_force = Vector2(_KOCKBACK_FORCE_X * enemy.move_mod , \
		_KOCKBACK_FORCE_Y)
	target.stun_timer.start()


#Kobold Hitbox collision detected
func _on_hitbox_area_entered(_area) -> void:
	target_hit()
