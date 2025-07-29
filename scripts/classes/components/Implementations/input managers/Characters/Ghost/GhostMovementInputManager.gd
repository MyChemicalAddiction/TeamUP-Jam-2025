extends InputManager
class_name GhostMovementInputManager

"""
The GhostMovementInputManager is a concrete implementation of the InputManager 
and manages inputs that are to be used somehow by the Ghost character's
other components (or by it itself) for movement.
"""

var vertical_input := 0.0
var horizontal_input := 0.0

var last_vertical_input := 0.0
var last_horizontal_input := 0.0

var toggle_amulet := false ## Whether the ghost player has pressed Shift to toggle the amulet state (i.e. to leave/enter the amulet)
var depossess := false ## True when the ghost wants to stop possessing an object by pressing the corresponding key.

## Emitted when the inputs received change from the previous frame.
signal input_changed 

func process_input():
	vertical_input = Input.get_axis("ghost_move_up", "ghost_move_down") ## The horizontal direction toward which the player is moving.
	horizontal_input = Input.get_axis("ghost_move_left", "ghost_move_right") ## The horizontal direction toward which the player is moving.
	
	if last_vertical_input != vertical_input or last_horizontal_input != horizontal_input:
		input_changed.emit()
	
	last_horizontal_input = horizontal_input
	last_vertical_input = vertical_input
	
	toggle_amulet = Input.is_action_just_released("toggle_amulet")
	depossess = Input.is_action_just_released("ghost_depossess") 
