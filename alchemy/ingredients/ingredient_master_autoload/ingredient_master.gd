extends Node

@export var ingredient_master_list: Array[IngredientResource]


func get_ingredient_index(p_ingredient: IngredientResource) -> int:
	var ingredient_index = ingredient_master_list.find(p_ingredient)
	if ingredient_index == -1:
		push_warning("Ingredient index not found")
	return ingredient_index 
