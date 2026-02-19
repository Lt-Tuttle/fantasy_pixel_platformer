class_name PlayerController
extends CharacterBody2D

@export_category("References")
@export var animation: AnimationPlayer
@export var movement: PlayerMovement
@export var input: PlayerInput
@export var sprite: Sprite2D
@export var state_machine: PlayerStateMachine
@export var hurtbox: Area2D
@export var hitbox: Area2D
@export var pivot: Node2D
@export var debug_label: Label

# State Variables for shorthand references
var current_state: Node
var previous_state: Node
@onready var air_state: Node = state_machine.state_air
@onready var ground_state: Node = state_machine.state_ground
@onready var attack_state: Node = state_machine.state_attack

# Local Variables
var double_jump_available: bool = false
var can_move: bool = true

func _physics_process(delta: float) -> void:
	# Update state references
	current_state = state_machine.current_state
	previous_state = state_machine.previous_state

	# Reset double jump when on floor
	if is_on_floor(): double_jump_available = false

	# Update input
	input.update()

	# Process inputs
	process_inputs()

	# 1. Update movement FIRST to fix the facing lag bug
	if can_move:
		movement.update(delta)

	# 2. Update state machine SECOND so check_facing() uses the newest velocity
	state_machine.update(delta)

	# Update debug label
	debug_label.text = state_machine.current_state.name

func process_inputs() -> void:
	# If the player enters the air state from the ground state, enable double jump
	if current_state == air_state and previous_state == ground_state:
		double_jump_available = true

	# Handle jump input
	if input.jump and is_on_floor():
		movement.jump()
		state_machine.change_state(air_state)
	elif input.jump and not is_on_floor() and double_jump_available:
		state_machine.state_lock = false
		movement.jump(0.85) # Double jump
		state_machine.change_state(air_state)
		double_jump_available = false

	# Handle attack input
	if input.attack and current_state != attack_state and is_on_floor():
		state_machine.change_state(attack_state)
