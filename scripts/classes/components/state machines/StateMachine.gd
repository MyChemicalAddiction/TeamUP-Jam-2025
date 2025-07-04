extends Component
class_name StateMachine

"""
The StateMachine implements the state pattern and allows using different
nodes as states (see State class).
"""

@export var starting_state: State ## The state that the thing will start in.
@export var object: Node ## The object which uses the functionality of this state machine.

var current_state ## The current state of the state machine.

func _ready(): ## Passes down the assigned object node to all the State children. Also initializes to the starting_state - an export variables which defines which state the StateMachine should be in on ready.
	for child in get_children():
		child.object = object
	
	change_state(starting_state)
	
func change_state(new_state:State): ## Calls the exiting & entering states' relevant functions.
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func process_physics(delta): ## Calls the current state's process_physics(delta) function, which can return another State - if it does, it means current_state should be changed to that.
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
