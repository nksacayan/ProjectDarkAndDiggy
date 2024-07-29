extends Label


func _ready() -> void:
	AutoloadScorekeeper.score_changed.connect(_update_score_label)
	_update_score_label(AutoloadScorekeeper.score)

func _update_score_label(p_score: int) -> void:
	text = str(p_score)
