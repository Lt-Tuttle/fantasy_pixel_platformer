class_name PlayerController
extends CharacterBody2D

@export var animation: AnimationPlayer
@export var movement: PlayerMovement
@export var input: PlayerInput
@export var sprite: Sprite2D
@export var state_machine: PlayerStateMachine
@export var hurtbox: Area2D
@export var hitbox: Area2D
@export var pivot: Node2D


func _physics_process(delta: float) -> void:
	input.update()
	state_machine.update()
	movement.move(delta)