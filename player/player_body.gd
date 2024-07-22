extends CharacterBody2D

const _MOVE_SPEED: float = 50000.0
const _JUMP_FORCE: float = -1000.0

var _gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	
	# Movement.
	velocity.x = ($PlayerInput as PlayerInput).walk_direction * _MOVE_SPEED * delta
	
	# Fall.
	velocity.y = velocity.y + _gravity * delta
	
	move_and_slide()

func _on_player_input_jump_input() -> void:
	_try_jump()

func _try_jump() -> void:
	if is_on_floor():
		velocity.y = _JUMP_FORCE
