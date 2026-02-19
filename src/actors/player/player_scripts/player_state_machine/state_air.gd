class_name StateAir
extends Node

# References
@export_category("References")
@export var player: PlayerController

func enter() -> void:
	# Lock state
	player.state_machine.state_lock = true

	# Play animation
	if player.velocity.y > 0:
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_FALL"])
	elif player.double_jump_available:
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_SOMERSAULT"])
	else:
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_JUMP"])


func exit() -> void:
	# Unlock state
	player.state_machine.state_lock = false


func update(_delta: float) -> void:
	# Check if player is on floor
	if player.is_on_floor():
		player.state_machine.change_state(player.state_machine.state_ground)
		return

	# Check if player is falling
	if player.velocity.y > 0:
		player.state_machine.state_lock = false
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_FALL"])
		return
