extends Control


func _on_restart_pressed():
	get_parent().load_main()
	self.queue_free()


func _on_quit_pressed():
	get_tree().quit()
