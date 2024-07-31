extends CanvasLayer


func _ready() -> void:
	visible = false
	get_tree().paused = false

func _on_button_back_pressed():
	_toggle_menu()
	
func _toggle_menu():
	visible = not visible
	_toggle_pause_tree()

func _unhandled_input(event : InputEvent):
	if event.is_action_pressed("toggle_pause_menu"):
		_toggle_menu()

func _on_button_quit_pressed():
	get_tree().quit()

func _toggle_pause_tree() -> void:
	get_tree().paused = not get_tree().paused
