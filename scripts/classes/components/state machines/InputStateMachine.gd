extends StateMachine
class_name InputStateMachine

## TODO: change this to be a generic InputStateMachine so it can be used by the amulet, too

"""
The InputStateMachine is a state machine whose States are InputStates. 
InputStates can get interchanged based on inputs received from an InputManager.
"""

func _process(delta: float) -> void:
	var new_state = current_state.process_input(delta)
	if new_state: change_state(new_state)
