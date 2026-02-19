extends Node
class_name PlayerMovement

# References
@export_category("References")
@export var player: PlayerController

# Movement variables
@export_category("Movement")
@export var speed: float = 300.0
@export var gravity: float = 800.0
@export var jump_force: float = -350.0

# Local Variables
var direction: Vector2 = Vector2.ZERO

func update(delta: float) -> void:
	# Get direction from input
	direction = player.input.direction

	# Apply movement
	player.velocity.x = direction.x * speed
	player.velocity.y += gravity * delta

	# Move the player
	player.move_and_slide()

func jump(jump_force_multiplier: float = 1.0) -> void:
	# Apply jump force
	player.velocity.y = jump_force * jump_force_multiplier