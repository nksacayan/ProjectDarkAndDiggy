class_name StateFactory

var states : Dictionary

func _init():
	states = {
		"patrol": PatrolState,
		#"chase": ChaseState
}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
