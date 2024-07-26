class_name PlayerBody
extends CharacterBody2D

const _MOVE_SPEED: float = 50000.0
const _JUMP_FORCE: float = -1000.0


var _gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var player_input: PlayerInput = %PlayerInput
@onready var digger: Digger = %Digger
@onready var health: Health = %Health
@onready var animation_handler: PlayerAnimationHandler = %AnimatedSprite2D as PlayerAnimationHandler
@onready var timer : Timer = %Timer
const _KNOCKBACK_DECAY : float = 100

var knockback_force : Vector2 = Vector2(0,0)

func _ready():
	health.current_health = health.max_health

func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		_do_movement(delta)
	else:
		_stunned_movement(delta)
	animation_handler.handle_animation(velocity)
	_try_digging()

func _on_player_input_jump_input() -> void:
	_try_jump()

func _try_jump() -> void:
	if is_on_floor():
		velocity.y = _JUMP_FORCE

#Stunned Movement when Hit by enemy unit
func _stunned_movement(delta: float):
	velocity = knockback_force * delta
	knockback_force / _KNOCKBACK_DECAY
	move_and_slide()

func _do_movement(delta: float) -> void:
	
	# Movement.
	velocity.x = player_input.walk_direction * _MOVE_SPEED * delta

	# Fall.
	velocity.y = velocity.y + _gravity * delta
	
	
	move_and_slide()

func _try_digging() -> void:
	digger.dig_in_direction(player_input.dig_direction)

func _check_target(area):
	var temp : StateMachine = area.get_parent().get_node("StateMachine")
	if temp.current_state.name == "PatrolState":
			print(temp.current_state.name)
			temp.get_parent().queue_free()
	else:
		print("Target not in Patrol State: currently in ", temp.current_state.name)
	
func _on_hitbox_area_entered(area):
	_check_target(area)

