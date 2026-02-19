extends Node
class_name PlayerMovement

#Get the player controller
@export_category("References")
@export var player: PlayerController

#Movement variables
@export_category("Movement")
@export var speed: float = 300.0
@export var gravity: float = 800.0
@export var jump_force: float = -350.0

#Local Variables
var direction: Vector2 = Vector2.ZERO

func move(delta: float) -> void:
	if not player: return

	direction = player.input.direction

	player.velocity.x = direction.x * speed
	player.velocity.y += gravity * delta

	#TODO: figure out where to handle jump listening, which script should be calling out actions for movement and animations
	#if player.input.jump:
	#	jump()
	#	player.input.jump = false
		
	player.move_and_slide()

func jump(jump_force_multiplier: float = 1.0) -> void:
	if player.is_on_floor():
		player.velocity.y = jump_force * jump_force_multiplier