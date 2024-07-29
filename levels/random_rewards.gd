extends Node

@export var reward_table : Array[ItemResource]

func _ready():
	var rng := RandomNumberGenerator.new()
	for child in get_children():
		child.item = reward_table[rng.randi_range(0, reward_table.size() - 1)]
		child._setup_sprite()
