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

signal entered ## The entered signal is emitted when the state is set as the current one (this can be used by things like various audio players, animation players, etc. for giving the players feedback).
signal exited ## The entered signal is emitted when the state is no longer the current one (this can be used by things like various audio players, animation players, etc. for giving the players feedback).

func enter(): ## What should happen when this becomes the active state.
	entered.emit()
	_on_enter()

func exit(): ## What should happen when this isn't the active state anymore.
	exited.emit()
	_on_exit()

func _on_enter(): ## Hook for extra behavior when entered.
	pass

func _on_exit(): ## Hook for extra behavior when exited.
	pass

func process_physics(delta): ## What this state should do every frame if it's active.
	return null
