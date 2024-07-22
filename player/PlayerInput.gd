class_name PlayerInput
extends Node

signal jump_input

var walk_direction: float

func _process(_delta: float) -> void:
	walk_direction = Input.get_axis("move_left", "move_right")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		jump_input.emit()
