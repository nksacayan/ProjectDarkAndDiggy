extends Node

@export var level_list: Array[PackedScene]

func _ready() -> void:
	if level_list.size() < 1:
		push_error("Level manager has no levels")
	add_child(level_list[0].instantiate())
