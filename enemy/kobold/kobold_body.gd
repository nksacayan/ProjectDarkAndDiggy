extends CharacterBody2D
class_name KoboldBody2D


@onready var sprite2D : Sprite2D = %Sprite2D
@onready var player_detect_cast : RayCast2D = %PlayerDetectionCast


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
	# Add the gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta
	# Fall.
	velocity.y = velocity.y + _gravity * delta
	
	move_and_slide()



