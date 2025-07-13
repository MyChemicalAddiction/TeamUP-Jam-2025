extends Component
class_name StateMachine

"""
The StateMachine implements the state pattern and allows using different
nodes as states (see State class).
"""

## The state that the thing will start in.
@export var starting_state: State 

## The object which uses the functionality of this state machine.
@export var object: Node 

## The current state of the state machine.
var current_state 

## Passes down the assigned object node to all the State children. Also initializes to the starting_state - an export variables which defines which state the StateMachine should be in on ready.
func _ready(): 
	for child in get_children():
		child.object = object
	
	_on_ready()
	change_state(starting_state)
	
## Overridden by implementations for extra behavior on ready
func _on_ready():
	pass

## Calls the exiting & entering states' relevant functions.
func change_state(new_state:State):
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

## Calls the current state's process_physics(delta) function, which can return another State - if it does, it means current_state should be changed to that.
func process_physics(delta): 
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
