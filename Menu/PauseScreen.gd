extends PanelContainer
class_name PauseMenu

func _ready():
	%Camera2D.make_current()
	
func _on_button_back_pressed():
	get_tree().paused = false
	get_parent().pause_ready =  true
	self.queue_free()


func _on_button_quit_pressed():
	get_tree().quit()
