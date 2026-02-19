extends Node
class_name StateAir

@export var player: PlayerController

func enter() -> void:
	player.state_machine.state_lock = true
	if player.velocity.y > 0:
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_FALL"])
	else:
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_JUMP"])

func exit() -> void:
	player.state_machine.state_lock = false

func update(_delta: float) -> void:
	if player.is_on_floor():
		player.state_machine.change_state(player.state_machine.state_ground)
		return

	if player.velocity.y > 0:
		player.state_machine.state_lock = false
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_FALL"])
		return
