extends Node
class_name InputManager

"""
The InputManager abstract class provides a shared interface for characters' 
input managers - nodes which manage select input (as defined by the 
implementation of the process_input function) that is meant to be used by other 
components of the characters.

For example, the HumanInputManager is a concrete implementation that provides
the variables horizontal_input and vertical_input, which are used by the 
Human player's MovementStateMachine to change state and move in certain ways 
based on the respective inputs.

References to InputManagers are usually assigned to concrete State 
implementations, which call their process_input function manually.
"""

func process_input(): ## Decide how to process the incoming inputs. Note that this is usually manually called by a concrete State implementation (see CharacterIdleState, for example).
	pass
