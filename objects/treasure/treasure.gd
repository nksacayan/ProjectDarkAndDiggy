class_name Treasure
extends Node2D

@export var value: int = 1
@export var sprites: Array[Texture2D]
@export var randomize_sprite: bool = true
# Amplitude of the bobbing motion (how high and low the node moves)
@export var amplitude: float = 20.0
# Frequency of the bobbing motion (how fast the node moves up and down)
@export var frequency: float = 1.0
@onready var sprite: Sprite2D = %Sprite2D
var initial_position: Vector2
var time_passed: float = 0.0


func _ready() -> void:
	if randomize_sprite:
		_randomize_sprite()
	initial_position = position

func _process(delta: float) -> void:
	_bob_and_float(delta)

## Should only trigger on player collisions due to mask
func _on_area_2d_body_entered(_body: Node2D) -> void:
	AutoloadScorekeeper.score += value
	queue_free()

func _randomize_sprite() -> void:
	var rng := RandomNumberGenerator.new()
	sprite.texture = sprites[rng.randi_range(0, sprites.size() - 1)]

func _bob_and_float(delta: float) -> void:
	time_passed += delta  # Accumulate time   
	# Calculate the new y position using sine wave
	var bobbing_offset = sin(2.0 * PI * frequency * time_passed) * amplitude
	position.y = initial_position.y + bobbing_offset
