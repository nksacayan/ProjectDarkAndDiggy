extends CharacterBody2D


const _MOVE_SPEED: float = 50000.0
const _JUMP_FORCE = -400.0

var patrol_bound : float = 50.0
var patrol_upper : float = 0.0
var patrol_lower : float = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var state : State
var state_factory : StateFactory

func _ready():
	state_factory = StateFactory.new()
	change_state("patrol")
	patrol_upper = position.x + patrol_bound
	patrol_lower = position.x - patrol_bound

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta
	# Fall.
	velocity.y = velocity.y + _gravity * delta
	
	move()

func move():
	state.move()

func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	print("state Created " + new_state_name)
	state.setup(Callable(self, "change_state"),$Sprite2D, self)
	add_child(state)
	
