extends Node2D


func _on_finish_line_area_entered(_area):
	get_parent().transistion_next_level()

