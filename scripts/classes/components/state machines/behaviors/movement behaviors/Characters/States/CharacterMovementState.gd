extends State
class_name CharacterMovementState

"""
A CharacterMovementState is a concrete implementation of the State superclass
and is meant to manage different kinds of movement (as defined by the 
implementation) via being controlled by a MovementStateMachine. It has a 
process_input(delta) function, which gets called alongside its process_physics,
because movement states usually depend (and changed based on) the relevant 
inputs being pressed. To that end, it also allows a reference to an 
InputManager implementation (such as the HumanInputManager).

Because CharacterMovementStates usually need to know about other relevant
movement states within the movement state machine they are part of, they must
keep variables to reference said other CharacterMovementStates. This is the
raison d'etre of the CharacterFallingState, CharacterIdleState, 
CharacterJumpingState and CharacterWalking state concrete implementations 
of CharacterMovementState - they provide only the references they need to other
Movement States. These are then THEMSELVES implemented by HumanFallingState,
GhostFallingState, etc. to provide concrete behavior definitions.
"""

@export var input_manager: InputManager ## Manages the input that controls what this state does/changes to.

func process_input(delta): ## Overridden to process input as provided by the input_manager and return a new state if needed.
	return null 
