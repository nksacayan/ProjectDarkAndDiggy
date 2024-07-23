# state.gd

extends Node2D

class_name State

var change_state #Callable Function to Change between Patrol and Chase State
var sprite2D #Enemy Sprit, used to flip when changing directions
var persistent_state # "Enemy" Unit. Should be kobolod_body.gd
var velocity = 0

# Writing _delta instead of delta here prevents the unused variable warning.
func _physics_process(_delta):
	print(" - Calling State Physics ")
	persistent_state.move_and_slide(persistent_state.velocity, Vector2.UP) #This IDK what its for but the godot docs had it sooo

func setup(change_state, sprite2D, persistent_state):
	self.change_state = change_state
	self.sprite2D = sprite2D
	self.persistent_state = persistent_state

func move(): #Passes movement implementation to the individual states.
	pass


