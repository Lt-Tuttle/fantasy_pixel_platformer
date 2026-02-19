class_name StateAttack
extends Node

@export_category("References")
@export var player: PlayerController

var can_combo: bool = false
var want_combo: bool = false
var combo_count: int = 1

func enter() -> void:
	# Reset combo variables in case the previous entry was interrupted
	can_combo = false
	want_combo = false
	combo_count = 1

	# Lock state and disable movement input
	player.state_machine.state_lock = true
	player.can_move = false

	# Force velocity to zero so the player halts immediately
	player.velocity = Vector2.ZERO

	# Play animation
	player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_ATTACK1"])


func exit() -> void:
	# Unlock state and re-enable movement
	player.state_machine.state_lock = false
	player.can_move = true


func update(_delta: float) -> void:
	# Latch the combo request if pressed during the valid combo window
	if player.input.attack and can_combo and not want_combo:
		want_combo = true

		# Queue the next animation immediately
		if combo_count == 1:
			player.animation.queue(GameConstants.ANIMS["PLAYER_ANIM_ATTACK2"])
			combo_count = 2
		elif combo_count == 2:
			player.animation.queue(GameConstants.ANIMS["PLAYER_ANIM_ATTACK3"])
			combo_count = 3

	# Only exit the state when the entire animation sequence finishes
	if not player.animation.is_playing():
		player.state_machine.state_lock = false
		player.state_machine.change_state(player.state_machine.state_ground)


# Called by animation frames
func start_combo() -> void:
	can_combo = true


# Called by animation frames
func end_combo() -> void:
	can_combo = false
	want_combo = false