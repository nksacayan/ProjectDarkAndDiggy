class_name PlayerBody
extends CharacterBody2D


signal earth_armor_activated(p_activated: bool)

const _MOVE_SPEED: float = 50000.0
const _JUMP_FORCE: float = -1100.0


var _gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var player_input: PlayerInput = %PlayerInput
@onready var digger: Digger = %Digger
@onready var health: Health = %Health
@onready var animation_handler: PlayerAnimationHandler = \
	%AnimatedSprite2D as PlayerAnimationHandler
@onready var stun_timer : Timer = %StunTimer

var knockback_force : Vector2 = Vector2(0,0)
var armor_flag : bool = false:
	set(value):
		armor_flag = value
		earth_armor_activated.emit(armor_flag)


func _ready():
	health.current_health = health.max_health

func _physics_process(delta: float) -> void:
	if stun_timer.is_stopped():
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
	move_and_slide()

func _do_movement(delta: float) -> void:
	
	# Movement.
	velocity.x = player_input.walk_direction * _MOVE_SPEED * delta

	# Fall.
	velocity.y = velocity.y + _gravity * delta
	
	
	move_and_slide()

func _try_digging() -> void:
	digger.dig_in_direction(player_input.dig_direction)

func _check_target(area) -> void:
	var enemy :KoboldBody2D = area.get_parent() as KoboldBody2D
	var sm : StateMachine = enemy.get_node("StateMachine")
	if sm.current_state.name == "ChaseState":
		if !armor_flag:
			return
		else:
			armor_flag = false
	AutoloadAudioManager.play_attack()
	enemy.die()

func _on_hitbox_area_entered(area) -> void:
	_check_target(area)

func _on_stun_timer_timeout():
	knockback_force = Vector2(0,0) # Reset Knockback Force

func _on_health_died():
	get_parent().get_parent().game_over(false)
