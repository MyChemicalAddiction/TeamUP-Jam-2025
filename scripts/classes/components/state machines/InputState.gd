extends State
class_name InputState

"""
A InputState is a concrete implementation of the State superclass
and is meant to implement functionality for being interchanged not just
based on physics processes, but also based on input (that is received from an
InputManager). 

It is the state that InputStateMachines has control of.

The process_input(delta) function, gets called alongside its process_physics
and does just that - processes input received from an InputManager.

Because InputStates usually need to know about other relevant
input states within the input state machine they are part of, they must
keep variables to reference said other InputStates. This is the raison d'etre of 
the CharacterFallingState, CharacterIdleState, 
CharacterJumpingState and CharacterWalking state concrete implementations 
of CharacterMovementState - they provide only the references they need to other
InputStates. These are then THEMSELVES implemented by HumanFallingState,
GhostFallingState, etc. to provide concrete behavior definitions.
"""

@export var input_manager: InputManager ## Manages the input that controls what this state does/changes to.

func process_input(_delta): ## Overridden to process input as provided by the input_manager and return a new state if needed.
	return null 
