extends Node

@export var mute: bool = false

func _ready():
	if not mute:
		play_music()

func play_music() -> void:
	if not mute:
		$Music.play()

func play_attack() -> void:
	if not mute:
		$Attack.play()
