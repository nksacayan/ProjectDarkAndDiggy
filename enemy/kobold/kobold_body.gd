extends CharacterBody2D
class_name KoboldBody2D

#Marker2D for Patrol Bounds and Start position
@onready var pb_right : Marker2D = %PatrolBoundRight
@onready var pb_left : Marker2D = %PatrolBoundLeft
@onready var pb_start : Marker2D = %PatrolBoundStart
@onready var sprite2D : Sprite2D = %Sprite2D

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

func _flip_direction(): 
	sprite2D.flip_h = not sprite2D.flip_h
	move_mod *= -1
