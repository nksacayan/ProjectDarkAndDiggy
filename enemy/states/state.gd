# state.gd
extends Node2D
class_name State

signal transitioned

#Thats allot of onReadys but we need 'em
@onready var pb_right : Marker2D = %PatrolBoundRight
@onready var pb_left : Marker2D = %PatrolBoundLeft
@onready var pb_start : Marker2D = %PatrolBoundStart
@onready var enemy : KoboldBody2D =  get_parent().get_parent()
@onready var light_beam : Sprite2D = %LightBeam
@onready var hitbox : Area2D = %Hitbox
@onready var los : RayCast2D = %LineOfSight
const LIGHTBEAM_SCALE_X : float = 1.5
const LIGHTBEAM_SCALE_Y : float = 4


func enter(_target) -> void:
	pass
	
func exit() -> void:
	pass
	
func update(_delta:float) -> void:
	pass
	
func physics_update(_delta:float) -> void:
	pass


