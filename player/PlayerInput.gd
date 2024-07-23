class_name PlayerInput
extends Node

signal jump_input

var walk_direction: float
var dig_direction: Vector2

func _process(_delta: float) -> void:
	_set_walk_direction()
	_set_dig_direction()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		jump_input.emit()

func _set_walk_direction() -> void:
	walk_direction = Input.get_axis("move_left", "move_right")

func _set_dig_direction() -> void:
	dig_direction.x = Input.get_axis("move_left", "move_right")
	dig_direction.y = Input.get_axis("jump", "dig_down")
	
	# Cardinal directions only
	# Prioritize vertical axis
	if dig_direction.y != 0:
		dig_direction.x = 0
