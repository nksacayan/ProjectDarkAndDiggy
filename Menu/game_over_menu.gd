class_name GameOverMenu
extends Control


@export var you_win: Texture2D
@export var game_over: Texture2D
@export var game_over_rect: TextureRect
@export var score: Label


func _ready() -> void:
	score.text = str(AutoloadScorekeeper.score)

func setup(p_did_win: bool) -> void:
	if p_did_win:
		game_over_rect.texture = you_win
	else:
		game_over_rect.texture = game_over

func _on_restart_pressed():
	get_parent().load_main()
	self.queue_free()

func _on_quit_pressed():
	get_tree().quit()
