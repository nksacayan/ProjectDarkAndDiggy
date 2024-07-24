extends CharacterBody2D

const _MOVE_SPEED: float = 50000.0
const _JUMP_FORCE: float = -1000.0

var _gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var player_input: PlayerInput = %PlayerInput
@onready var digger: Digger = %Digger
@onready var health: Health = %Health
@onready var animation_handler: PlayerAnimationHandler = %AnimatedSprite2D as PlayerAnimationHandler


func _physics_process(delta: float) -> void:
	_do_movement(delta)
	animation_handler.handle_animation(velocity)
	_try_digging()

func _on_player_input_jump_input() -> void:
	_try_jump()

func _try_jump() -> void:
	if is_on_floor():
		velocity.y = _JUMP_FORCE

func _do_movement(delta: float) -> void:
	# Movement.
	velocity.x = player_input.walk_direction * _MOVE_SPEED * delta
	
	# Fall.
	velocity.y = velocity.y + _gravity * delta
	
	move_and_slide()

func _try_digging() -> void:
	digger.dig_in_direction(player_input.dig_direction)
