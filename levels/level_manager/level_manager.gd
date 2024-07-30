class_name LevelManager
extends Node

signal next_level_transitioned
@export var main_menu: PackedScene
@export var game_over_scene: PackedScene
@export var pause_menu_scene: PackedScene
@export var level_list: Array[PackedScene]
var level_select : int = 0
var pause_ready : bool = false

func _ready() -> void:
	load_main()

#Avoid Changing states while physics are being processed
#Calls method during an idle time
func transistion_next_level() -> void:
	if !pause_ready:
			pause_ready = true
	call_deferred("_deferred_transition_next_level")

#Deffered call to tranistion into next level in array
func _deferred_transition_next_level() -> void:
	if level_select >= level_list.size():
		game_over(true)
		return
	get_child(0).queue_free() #Hopefully Frees Finished Level ¯\_(ツ)_/¯
	add_child(level_list[level_select].instantiate())
	level_select += 1
	next_level_transitioned.emit()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_pause_menu") and pause_ready:
		pause_ready = false
		add_child(pause_menu_scene.instantiate())
		get_tree().paused = true
		

		
		

func load_main() -> void:
	if !main_menu:
		push_error("Error: No Main Menu")
	level_select = 0
	add_child(main_menu.instantiate())

func game_over(did_win: bool) -> void:
	pause_ready = false
	call_deferred("_defered_game_over", did_win)

func _defered_game_over(did_win: bool) -> void:
	get_child(0).queue_free() #Hopefully Frees Finished Level ¯\_(ツ)_/¯
	var game_over_menu: GameOverMenu = game_over_scene.instantiate() as GameOverMenu
	game_over_menu.setup(did_win)
	add_child(game_over_menu)
	
