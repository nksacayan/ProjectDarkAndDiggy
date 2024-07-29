extends Control

func _on_button_pressed():
	get_parent().load_main()
	self.queue_free()
