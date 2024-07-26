class_name Health
extends Node

signal died

@export var max_health: int = 1

var current_health: int:
	get:
		return current_health
	set(p_value):
		current_health = clampi(p_value, 0, max_health)
		if current_health <= 0:
			died.emit()


