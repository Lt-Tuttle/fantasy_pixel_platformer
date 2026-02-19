extends Node
class_name StateGround

@export var player: PlayerController

func enter() -> void:
	if player.velocity.x != 0:
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_RUN_UNARMED"])
	else:
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_IDLE_UNARMED"])

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if player.input.jump or not player.is_on_floor():
		player.state_machine.change_state(player.state_machine.state_air)
		return

	if player.velocity.x != 0:
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_RUN_UNARMED"])
	else:
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_IDLE_UNARMED"])
