extends Node

signal ingredients_updated
signal potion_updated

var _left_ingredient: IngredientResource:
	set(p_value):
		_left_ingredient = p_value
		ingredients_updated.emit()
var _right_ingredient: IngredientResource:
	set(p_value):
		_right_ingredient = p_value
		ingredients_updated.emit()

var potion_result: PotionResource:
	set(p_value):
		potion_result = p_value
		potion_updated.emit()

## Returns true if an ingredient was added
func add_ingredient(p_ingredient: IngredientResource) -> bool:
	if not _left_ingredient:
		_left_ingredient = p_ingredient
		return true
	elif not _right_ingredient:
		_right_ingredient = p_ingredient
		return true
	else:
		return false

func remove_ingredient(p_ingredient: IngredientResource) -> void:
	if _left_ingredient == p_ingredient:
		_left_ingredient = null
	elif _right_ingredient == p_ingredient:
		_right_ingredient = null
	else:
		push_warning("Tried to remove ingredient the mixer doesn't hold")

func mix() -> void:
	if not _left_ingredient or not _right_ingredient:
		return

	var right_ingredient_index: int = \
		AutoloadIngredientMaster.get_ingredient_index(_right_ingredient)
	potion_result = _left_ingredient.combo_result[right_ingredient_index]
	
	_clear_ingredients()

func _clear_ingredients() -> void:
	_left_ingredient = null
	_right_ingredient = null
