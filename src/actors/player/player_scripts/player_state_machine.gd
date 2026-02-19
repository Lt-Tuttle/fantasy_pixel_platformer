extends Node
class_name PlayerStateMachine

@export var player: PlayerController

var _current_state: String
var _floor_check: bool

func update() -> void:
	if not player: return

	_floor_check = player.is_on_floor()

	check_facing()
	check_run()
	check_idle()
	check_jump()
	check_fall()

func check_facing() -> void:
	if player.velocity.x != 0:
		player.pivot.scale.x = sign(player.velocity.x)
	return

func check_run() -> void:
	if player.velocity.x != 0 and _floor_check:
		_current_state = "run"
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_RUN_UNARMED"])
	return

func check_idle() -> void:
	if player.velocity.x == 0 and _floor_check:
		_current_state = "idle"
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_IDLE_UNARMED"])
	return

func check_jump() -> void:
	if player.input.jump and _current_state == "jump":
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_SOMERSAULT"])
		player.movement.jump()
		return

	if player.input.jump and _current_state != "jump":
		_current_state = "jump"
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_JUMP"])
	return

func check_fall() -> void:
	if not _floor_check and player.velocity.y > 0:
		_current_state = "fall"
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_FALL"])
	return
