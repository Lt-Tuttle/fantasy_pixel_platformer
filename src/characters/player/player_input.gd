class_name PlayerInput
extends Node

# References
@export_category("References")
@export var player: PlayerController

# Local Variables
var direction: Vector2 = Vector2.ZERO
var jump: bool = false
var attack: bool = false

func update() -> void:
	var move_right = Input.get_action_strength("move_right")
	var move_left = Input.get_action_strength("move_left")

	direction.x = move_right - move_left

	jump = Input.is_action_just_pressed("jump")
	attack = Input.is_action_just_pressed("attack")