class_name Digger
extends Node2D

const HORIZONTAL_TARGET_DISTANCE: int = 96
const VERTICAL_TARGET_DISTANCE: int = 160
const DEFAULT_TILE_LAYER: int = 1
const TARGET_CELL_SENTINEL_VALUE: Vector2i = Vector2i.MIN

@onready var raycast: RayCast2D = %RayCast2D
@onready var dig_timer: Timer = %DigTimer

var target_tilemap: TileMap
var target_cell: Vector2i = TARGET_CELL_SENTINEL_VALUE


## Expects Vector2 Unit Vectors
func dig_in_direction(direction: Vector2):
	if direction == Vector2.ZERO:
		raycast.target_position = Vector2.ZERO
		_stop_digging()
		return

	# normalize() call is for safety
	raycast.target_position = direction.normalized()
	if raycast.target_position.x != 0:
		raycast.target_position.x *= HORIZONTAL_TARGET_DISTANCE
	elif raycast.target_position.y != 0:
		raycast.target_position.y *= VERTICAL_TARGET_DISTANCE
	
	_cast_for_diggables()

func _start_digging(p_tilemap: TileMap, p_tile_cell_coords: Vector2i) -> void:
	target_cell = p_tile_cell_coords
	target_tilemap = p_tilemap
	dig_timer.start()
	
func _stop_digging() -> void:
	dig_timer.stop()
	target_cell = TARGET_CELL_SENTINEL_VALUE
	target_tilemap = null

func _execute_dig() -> void:
	if not target_tilemap or target_cell == Vector2i.MIN:
		print_stack()
		push_error("Tried to dig while target tilemap or cell not set.")
	target_tilemap.erase_cell(DEFAULT_TILE_LAYER, target_cell)
	_stop_digging()

func _cast_for_diggables() -> void:
	var tilemap: TileMap = raycast.get_collider() as TileMap
	if not tilemap:
		_stop_digging()
		return
	
	# collision point is in global coords
	var collision_point: Vector2 = raycast.get_collision_point()
	
	# move collision deeper into collider to ensure we get the right cell
	# tilemap cells are inclusive left bound but exclusive right bound
	# added thickness factor since it still broke at the edges if I only added 1 pixel
	const RAYCAST_THICKNESS_FACTOR: int = 64
	var adjusted_collision_point: Vector2 	= collision_point + \
		-raycast.get_collision_normal() * RAYCAST_THICKNESS_FACTOR
	
	var local_point: Vector2 = tilemap.to_local(adjusted_collision_point)
	var map_point: Vector2i = tilemap.local_to_map(local_point)
	
	# if same target as last frame, do not touch timer and do not touch targets
	if not _is_new_dig_target(tilemap, map_point):
		return
	
	var tile_data: TileData = tilemap.get_cell_tile_data(DEFAULT_TILE_LAYER, map_point)
	const DESTRUCTIBLE_LAYER_NAME: String = "destructible"
	if tile_data and tile_data.get_custom_data(DESTRUCTIBLE_LAYER_NAME):
		_start_digging(tilemap, map_point)

func _is_new_dig_target(p_new_target_tilemap: TileMap, p_new_target_cell: Vector2i) -> bool:
	return target_tilemap != p_new_target_tilemap or target_cell != p_new_target_cell

func _on_dig_timer_timeout() -> void:
	_execute_dig()
