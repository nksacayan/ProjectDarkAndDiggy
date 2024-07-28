extends Node2D


func _on_finish_line_area_entered(_area):
	print_debug("Finish Line Flag Hit")
	get_parent().transistion_next_level()

