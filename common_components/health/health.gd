class_name Health
extends Node

signal died
signal health_changed(p_health: int)

@export var max_health: int = 1

var current_health: int:
	get:
		return current_health
	set(p_value):
		current_health = clampi(p_value, 0, max_health)
		health_changed.emit(current_health)
		if current_health <= 0:
			died.emit()


