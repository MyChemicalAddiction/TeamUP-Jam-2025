extends RigidBody2D

@export var stateMachine: StateMachine

func _physics_process(delta: float) -> void:
	stateMachine.process_physics(delta)
