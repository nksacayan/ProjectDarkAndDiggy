extends CharacterBody2D
class_name KoboldBody2D

const _JUMP_FORCE: float = -1000.0
@onready var player_detect_cast : ShapeCast2D = %PlayerDetectionCast
@onready var floor_detect_cast : RayCast2D = %FloorDetectionCast
@onready var light_detect_cast : ShapeCast2D = %LightDetectionCast
@onready var animation_handler: KoboldAnimationHandler = \
	%AnimatedSprite2D as KoboldAnimationHandler
var floor_cast_ready : bool = false

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
	
	_update_los()
	check_floor()
	if is_on_wall():
		_try_jump()
	move_and_slide()

func _update_los():
	pass

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
	


