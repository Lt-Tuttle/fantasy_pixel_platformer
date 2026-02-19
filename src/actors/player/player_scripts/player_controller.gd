class_name PlayerController
extends CharacterBody2D

@export var animation_player: AnimationPlayer
@export var movement: PlayerMovement
@export var input: PlayerInput
@export var sprite: Sprite2D


func _ready() -> void:
	if movement:
		movement.player = self
	if input:
		input.player = self

func _physics_process(delta: float) -> void:
	input.update()
	movement.move(delta)