extends Node2D

@export var state_machine: StateMachine

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
