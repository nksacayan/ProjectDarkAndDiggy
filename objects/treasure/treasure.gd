class_name Treasure
extends Node2D

@export var value: int = 1


## Should only trigger on player collisions due to mask
func _on_area_2d_body_entered(_body: Node2D) -> void:
	ScorekeeperSingleton.score += value
	queue_free()
