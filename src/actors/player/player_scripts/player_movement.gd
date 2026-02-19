extends Node
class_name PlayerMovement

@export var speed: float = 100.0
@export var gravity: float = 1000.0

var player: PlayerController

func move(delta: float) -> void:
	if not player:
		return

	var direction = player.input.direction.x

	player.velocity.x = direction * speed
	player.velocity.y += gravity * delta
	player.move_and_slide()