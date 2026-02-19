class_name PlayerController
extends CharacterBody2D

@export var animation: AnimationPlayer
@export var movement: PlayerMovement
@export var input: PlayerInput
@export var sprite: Sprite2D
@export var state_machine: PlayerStateMachine
@export var hurtbox: Area2D
@export var hitbox: Area2D
@export var pivot: Node2D

@export var debug_label: Label

func _physics_process(delta: float) -> void:
	input.update()
	process_inputs()
	state_machine.update(delta)
	movement.update(delta)

	debug_label.text = state_machine.current_state.name

func process_inputs() -> void:
	if input.jump and is_on_floor():
		state_machine.change_state(state_machine.state_air)
		movement.jump()