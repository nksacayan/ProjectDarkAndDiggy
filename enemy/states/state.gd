# state.gd
extends Node2D
class_name State

signal transitioned

#Marker2D for Patrol Bounds and Start position
@onready var pb_right : Marker2D = %PatrolBoundRight
@onready var pb_left : Marker2D = %PatrolBoundLeft
@onready var pb_start : Marker2D = %PatrolBoundStart
@onready var enemy : KoboldBody2D =  get_parent().get_parent()
@onready var hitbox : Area2D = %Hitbox
@onready var los : RayCast2D = %LineOfSight

func enter(_player:PlayerBody):
	pass
	
func exit():
	pass
	
func update(_delta:float):
	pass
	
func physics_update(_delta:float):
	pass


