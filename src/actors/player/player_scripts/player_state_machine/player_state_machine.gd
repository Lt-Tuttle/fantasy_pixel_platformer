extends Node
class_name PlayerStateMachine

# References
@export_category("References")
@export var player: PlayerController
@export var state_ground: StateGround
@export var state_air: StateAir
@export var state_attack: StateAttack

# Local Variables
var current_state: Node
var previous_state: Node
var state_lock: bool = false

func _ready() -> void:
	current_state = state_ground
	current_state.enter()

func update(delta: float) -> void:
	check_facing()
	current_state.update(delta)

func change_state(new_state: Node) -> void:
	if state_lock: return

	current_state.exit()
	previous_state = current_state
	current_state = new_state
	current_state.enter()

func check_facing() -> void:
	if player.pivot.scale.x != sign(player.velocity.x) and player.velocity.x != 0:
		player.pivot.scale.x = sign(player.velocity.x)
