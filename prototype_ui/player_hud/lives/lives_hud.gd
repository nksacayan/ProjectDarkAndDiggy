extends HBoxContainer

@export var full_heart: Texture2D
@export var empty_heart: Texture2D
@export var heart_rect_scene: PackedScene
var hearts: Array[TextureRect]
var num_hearts: int = 3
var saved_player: PlayerBody

func _ready() -> void:
	await _setup_health_relationship()
	_setup_hearts()

func _setup_hearts() -> void:
	# clear hearts
	for child in get_children():
		child.queue_free()
	# add max health hearts
	for i in num_hearts:
		var new_heart_rect: TextureRect = heart_rect_scene.instantiate() as TextureRect
		hearts.append(new_heart_rect)
		add_child(new_heart_rect)
	var player: PlayerBody = await _get_player()
	_update_hearts(player.health.current_health)

func _setup_health_relationship() -> void:
	var player: PlayerBody = await _get_player()
	num_hearts = player.health.max_health
	player.health.health_changed.connect(_update_hearts)

func _get_player() -> PlayerBody:
	if saved_player:
		return saved_player
	
	var current_scene = get_tree().current_scene
	await current_scene.ready
	print_debug(current_scene.get_children())
	if current_scene as LevelManager:
		current_scene = current_scene.get_child(0)
	saved_player = current_scene.find_child("PlayerBody")
	return saved_player

func _update_hearts(p_health: int) -> void:
	for heart in hearts:
		if p_health > 0:
			heart.texture = full_heart
		else:
			heart.texture = empty_heart
		p_health -= 1


