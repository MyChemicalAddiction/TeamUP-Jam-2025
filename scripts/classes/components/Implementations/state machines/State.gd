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

## The object upon which this state acts.
var object: Node 

## The entered signal is emitted when the state is set as the current one (this can be used by things like various audio players, animation players, etc. for giving the players feedback).
signal entered 

## The entered signal is emitted when the state is no longer the current one (this can be used by things like various audio players, animation players, etc. for giving the players feedback).
signal exited

## What should happen when this becomes the active state.
func enter(): 
	entered.emit()
	_on_enter()

## What should happen when this isn't the active state anymore.
func exit(): 
	exited.emit()
	_on_exit()

## Hook for extra behavior when entered.
func _on_enter(): 
	pass

## Hook for extra behavior when exited.
func _on_exit(): 
	pass

## What this state should do every frame if it's active.
func process_physics(_delta):
	return null
