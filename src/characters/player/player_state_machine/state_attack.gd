class_name StateAttack
extends Node

@export_category("References")
@export var player: PlayerController

# State Variables
var can_combo: bool = false
var want_combo: bool = false
var combo_count: int = 1

# Short-hand variables
var air_attack2 = GameConstants.ANIMS["PLAYER_ANIM_AIR_ATTACK2"]
var air_attack3_ready = GameConstants.ANIMS["PLAYER_ANIM_AIR_ATTACK3_READY"]
var air_attack3_loop = GameConstants.ANIMS["PLAYER_ANIM_AIR_ATTACK3_LOOP"]
var air_attack3_end = GameConstants.ANIMS["PLAYER_ANIM_AIR_ATTACK3_END"]

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
	if player.is_on_floor():
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_ATTACK1"])
	else:
		player.animation.play(GameConstants.ANIMS["PLAYER_ANIM_AIR_ATTACK1"])


func exit() -> void:
	# Unlock state and re-enable movement
	player.state_machine.state_lock = false
	player.can_move = true
	end_combo()


func update(_delta: float) -> void:
	# Latch the combo request if pressed during the valid combo window
	if player.input.attack and can_combo and not want_combo:
		want_combo = true

		# Queue the next animation immediately
		if combo_count == 1:
			if player.is_on_floor():
				player.animation.queue(GameConstants.ANIMS["PLAYER_ANIM_ATTACK2"])
			else:
				print("Air attack 2")
				player.animation.queue(GameConstants.ANIMS["PLAYER_ANIM_AIR_ATTACK2"])
				# TODO: Add a timer here to ensure hang at the "ready" pose for 0.1 seconds befor allowing attack 3
			combo_count = 2
		elif combo_count == 2:
			if player.is_on_floor():
				player.animation.queue(GameConstants.ANIMS["PLAYER_ANIM_ATTACK3"])
				combo_count = 3

	# Short-hand variables
	var anim = player.animation.current_animation
	if anim == "":
		anim = player.animation.assigned_animation

	var anim_playing = player.animation.is_playing()

	# Pause on the last frame of air_attack2
	if not anim_playing and anim == air_attack2 and not player.is_on_floor():
		if player.input.attack or player.input.attack_held:
			combo_count = 3
			player.animation.play(air_attack3_ready)
			player.animation.queue(air_attack3_loop)
			player.can_move = true

	# Check for holding attack during air attack 3
	if anim == air_attack3_ready or anim == air_attack3_loop:
		if not player.input.attack_held:
			player.can_move = false
			player.animation.play(air_attack3_end)

		if player.is_on_floor():
			player.can_move = false
			player.animation.play(air_attack3_end)

	# Only exit the state when the entire animation sequence finishes
	if not anim_playing:
		if anim == air_attack2 and not player.is_on_floor():
			pass # Freeze here
		else:
			player.state_machine.state_lock = false
			if not player.is_on_floor():
				player.state_machine.change_state(player.state_machine.state_air)
			else:
				player.state_machine.change_state(player.state_machine.state_ground)


# Called by animation frames
func start_combo() -> void:
	can_combo = true


# Called by animation frames
func end_combo() -> void:
	can_combo = false
	want_combo = false