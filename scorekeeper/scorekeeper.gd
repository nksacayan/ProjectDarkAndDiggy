extends Node

signal score_changed(p_new_score)

var score: int = 0:
	get:
		return score
	set(p_value):
		score = p_value
		score_changed.emit(score)
