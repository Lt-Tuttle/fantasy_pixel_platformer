class_name PlayerInput
extends Node


var player: PlayerController
var direction: Vector2 = Vector2.ZERO

func update() -> void:
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")