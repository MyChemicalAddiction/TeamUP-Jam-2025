extends StateMachine
class_name MovementStateMachine

"""
The MovementStateMachine is a state machine whose States are
CharacterMovementStates. Characters delegate movement logic to the
MovementStateMachine, and the MovementStateMachine delegates logic to its
states.
"""

func _process(delta: float) -> void:
	var new_state = current_state.process_input(delta)
	if new_state: change_state(new_state)
