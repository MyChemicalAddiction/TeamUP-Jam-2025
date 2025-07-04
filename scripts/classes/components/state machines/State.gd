extends Component
class_name State

"""
The State superclass allows implementing the state pattern via node-based states,
which should keep them modular, reusable and flexibly assignable at runtime.

A State can have specific behavior upon:
	-being set as the current one;
	-being replaced by another one;
	-every frame of the game (via process_physics(delta) - which gets called
	by the parent StateMachine implementation.)
"""

var object: Node ## The object upon which this state acts.

func enter(): ## What should happen when this becomes the active state.
	pass

func exit(): ## What should happen when this isn't the active state anymore.
	pass

func process_physics(delta): ## What this state should do every frame if it's active.
	return null
