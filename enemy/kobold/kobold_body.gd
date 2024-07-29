extends CharacterBody2D
class_name KoboldBody2D

const _JUMP_FORCE: float = -1500.0
@onready var stun_timer : Timer = %StunTimer
@onready var state_mach : StateMachine = %StateMachine
@onready var player_detect_cast : ShapeCast2D = %PlayerDetectionCast
@onready var floor_detect_cast : RayCast2D = %FloorDetectionCast
@onready var light_detect_cast : ShapeCast2D = %LightDetectionCast
@onready var animation_handler: KoboldAnimationHandler = \
	%AnimatedSprite2D as KoboldAnimationHandler
var floor_cast_ready : bool = false
var knockback_force : Vector2 = Vector2(0,0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

#Used to transform Velocity of movement
var move_mod : MovementModifier = MovementModifier.RIGHT

enum MovementModifier {
	LEFT = -1,
	CENTER = 0,
	RIGHT = 1
}

func _physics_process(delta):
	apply_gravity(delta)
	animation_handler.handle_animation(velocity)
	
	check_floor()
	if is_on_wall():
		_try_jump()
	
	if !stun_timer.is_stopped():
		stunned_movement(delta)
	else:
		_do_movement(delta)
	
	move_and_slide()

func stunned_movement(delta):
	velocity = knockback_force * delta

func _do_movement(delta:float):
	velocity.x = state_mach.current_state._MOVE_SPEED * move_mod * delta


func check_floor():
	
	#Runs when raycast Finds a hole in the floor
	if !floor_detect_cast.is_colliding():
		_try_jump()
		
func _try_jump():
	if is_on_floor():
		velocity.y += _JUMP_FORCE
		
func apply_gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta
	# Fall.
	velocity.y = velocity.y + _gravity * delta
	

func _on_stun_timer_timeout():
	knockback_force = Vector2(0,0) #Reset Knockback Force
