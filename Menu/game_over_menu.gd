extends Control


@export var you_win: Texture2D
@export var game_over: Texture2D


func _on_restart_pressed():
	get_parent().load_main()
	self.queue_free()


func _on_quit_pressed():
	get_tree().quit()
