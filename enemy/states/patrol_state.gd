extends State

class_name PatrolState

var move_mod : MovementModifier = MovementModifier.CENTER;

var patrol_bound : float = 500.0
var patrol_upper : float = 0.0
var patrol_lower : float = 0.0

enum MovementModifier {
	LEFT = -1,
	CENTER = 0,
	RIGHT = 1
}


func _ready():
	print("Patrol Ready")
	move_mod = MovementModifier.RIGHT
	patrol_upper = persistent_state.position.x + patrol_bound
	patrol_lower = persistent_state.position.x - patrol_bound

#change_state.call_func("chase") will change State to Chase
func _physics_process(_delta):
	print(" - Calling Patrol Physics ")
	persistent_state.velocity.x = persistent_state._MOVE_SPEED * move_mod * _delta
	persistent_state.move_and_slide()
	

func _flip_direction():
	sprite2D.flip_h = not sprite2D.flip_h
	move_mod = move_mod * -1
	print("Flipped")


func move():
	print(" - Calling Patrol move ")
	print(persistent_state.position)
	print(patrol_upper)
	if persistent_state.position.x >= patrol_upper || persistent_state.position.x <= patrol_lower:
		_flip_direction()
	

