extends Node2D


func _on_finish_line_area_entered(_area):
	print("SIGNAL HIT")
	get_parent().transistion_next_level()

