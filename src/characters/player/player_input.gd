class_name PlayerInput
extends Node

# References
@export_category("References")
@export var player: PlayerController

# Directional Variables
var direction: Vector2

# Action Variables
var jump: bool
var jump_held: bool
var attack: bool
var attack_held: bool
var crouch: bool
var crouch_held: bool

# Local Variables
var move_right: float
var move_left: float

func update() -> void:
	move_right = Input.get_action_strength("move_right")
	move_left = Input.get_action_strength("move_left")

	direction.x = move_right - move_left

	jump = Input.is_action_just_pressed("jump")
	jump_held = Input.is_action_pressed("jump")
	attack = Input.is_action_just_pressed("attack")
	attack_held = Input.is_action_pressed("attack")
	crouch = Input.is_action_just_pressed("crouch")
	crouch_held = Input.is_action_pressed("crouch")