class_name LevelManager
extends Node

@export var level_list: Array[PackedScene]
var level_select : int = 0

func _ready() -> void:
	if level_list.size() < 1:
		push_error("Level manager has no levels")
	add_child(level_list[level_select].instantiate())

#Avoid Changing states while physics are being processed
#Calls method during an idle time
func transistion_next_level():
	call_deferred("_deferred_transition_next_level")

#Deffered call to tranistion into next level in array
func _deferred_transition_next_level():
	get_child(0).queue_free() #Hopefully Frees Finished Level ¯\_(ツ)_/¯
	level_select += 1
	add_child(level_list[level_select].instantiate())
