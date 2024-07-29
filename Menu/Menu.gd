extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_start_button_pressed():
	get_parent().transistion_next_level()

func _on_credits_button_pressed():
	get_parent().add_child(load("res://Menu/credits_page.tscn").instantiate())
	self.queue_free()

func _on_quit_button_pressed():
	get_tree().quit()
