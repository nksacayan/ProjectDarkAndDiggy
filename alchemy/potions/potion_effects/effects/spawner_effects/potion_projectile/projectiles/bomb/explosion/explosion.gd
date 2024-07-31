class_name Explosion
extends Area2D


const DEFAULT_TILE_LAYER = 1


func _on_body_entered(body: Node2D) -> void:
	var tilemap_collision: TileMap = body as TileMap
	var cells_to_destroy: Array[Vector2i] = []
	if tilemap_collision:
		cells_to_destroy = _get_all_destructible_tile_cells_bfs(tilemap_collision)

	# clear destroyable cells
	for cell in cells_to_destroy:
		var tile_data := tilemap_collision.get_cell_tile_data(DEFAULT_TILE_LAYER, cell)
		if tile_data:
				tilemap_collision.erase_cell(DEFAULT_TILE_LAYER, cell)

func _get_all_destructible_tile_cells_bfs(p_tilemap: TileMap) -> Array[Vector2i]:
	var destructible_cells: Array[Vector2i] = []
	var visited: Array[Vector2i] = []
	var to_visit: Array[Vector2i] = []
	var depth = 9 # fuck i don't remember how to do this
	
	# get tilemap cell i am in
	var tilemap_local_position := p_tilemap.to_local(global_position)
	var tilemap_cell_position := p_tilemap.local_to_map(tilemap_local_position)
	
	to_visit.push_front(tilemap_cell_position)
	visited.push_front(tilemap_cell_position)
	
	while visited.size() > 0 and depth > 0:
		# get all cells that are neighbors depth == 1
		var cell_to_visit: Vector2i = to_visit.pop_back()
		var neighbors: Array[Vector2i] = p_tilemap.get_surrounding_cells(cell_to_visit)
		for neighbor in neighbors:
			if neighbor not in visited:
				visited.push_front(neighbor)
				to_visit.push_front(neighbor)
		depth -= 1
	
	# only add destructible cells from visited to destructible
	for visited_cell in visited:
		var tilemap_data: TileData = p_tilemap.get_cell_tile_data(DEFAULT_TILE_LAYER, visited_cell)
		if tilemap_data and \
			(tilemap_data.get_custom_data("destructible") or\
			 tilemap_data.get_custom_data("strong_destructible")):
				destructible_cells.append(visited_cell)
	return destructible_cells

func _on_area_entered(area: Area2D) -> void:
	const PLAYER_HURTBOX_LAYER = 6
	const ENEMY_HURTBOX_LAYER = 7
	# if collides with player hurtbox
	if area.get_collision_layer_value(PLAYER_HURTBOX_LAYER):
		_damage_player(area)
	# if collides with enemy hurtbox
	if area.get_collision_layer_value(ENEMY_HURTBOX_LAYER):
		_kill_enemy(area)

func _damage_player(area: Area2D) -> void:
	var player: PlayerBody = area.get_parent() as PlayerBody
	if player:
		player.health.current_health -= 1

func _kill_enemy(p_area: Area2D) -> void:
	(p_area.get_parent() as KoboldBody2D).die()

func _on_sprite_2d_animation_finished() -> void:
	queue_free()
