extends PotionProjectile

const DEFAULT_TILE_LAYER = 1

func _on_hitbox_body_entered(body: Node2D) -> void:
	var tilemap_collision: TileMap = body as TileMap
	if tilemap_collision:
		_spawn_dirt(tilemap_collision)
	queue_free()

func _spawn_dirt(p_tilemap: TileMap) -> void:
	var local_cell: Vector2 = p_tilemap.to_local(global_position)
	var map_cell: Vector2i = p_tilemap.local_to_map(local_cell)
	# get cells in a cross
	var target_cells: Array[Vector2i] = [map_cell]
	target_cells.append(p_tilemap.get_neighbor_cell(map_cell, TileSet.CELL_NEIGHBOR_LEFT_SIDE))
	target_cells.append(p_tilemap.get_neighbor_cell(map_cell, TileSet.CELL_NEIGHBOR_RIGHT_SIDE))
	target_cells.append(p_tilemap.get_neighbor_cell(map_cell, TileSet.CELL_NEIGHBOR_TOP_SIDE))
	target_cells.append(p_tilemap.get_neighbor_cell(map_cell, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
	
	for cell in target_cells:
		var tile_data: TileData = p_tilemap.get_cell_tile_data(DEFAULT_TILE_LAYER, cell) as TileData
		if not tile_data:
			p_tilemap.set_cell(DEFAULT_TILE_LAYER, cell, 31, Vector2i(1, 1))
