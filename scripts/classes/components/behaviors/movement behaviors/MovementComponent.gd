extends Component
class_name MovementComponent 

"""
The MovementComoponent provides a shared interface for components that handle
movement of the two players. To implement a MovementComponent, define the
_handle_movement method signature to make the player move (NOTE: the player
is referenced by the character variable, to which the corresponding character
assigns itself at its ready - see Character).
"""

@export var character: Node ## The character which uses the functionality of this component.

func _handle_movement(delta): ## Method signature for a hook that defines movement behavior.
	push_error("Undefined _handle_movement method in MovementComponent")

func _process(delta): ## A MovementComponent uses a _process function to check for corresponding implementation-defined input that triggers certain movements to occur.
	move(delta)

func move(delta): ## Moves the character.
	if enabled:
		_handle_movement(delta)
