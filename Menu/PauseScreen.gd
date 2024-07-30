extends PanelContainer
class_name PauseMenu

func _ready():
	%Camera2D.make_current()
	
func _on_button_back_pressed():
	_toggle_menu()
	
func _toggle_menu():
	get_tree().paused = false
	self.queue_free()
	

func _unhandled_input(event : InputEvent):
	if event.is_action_pressed("toggle_pause_menu"):
		_toggle_menu()

func _on_button_quit_pressed():
	get_tree().quit()
