extends InputManager
class_name HumanMovementInputManager

"""
The HumanMovementInputManager is a concrete implementation of the InputManager 
and manages inputs that are to be used somehow by the Human character's
other components (or by it itself) for moving.
"""

var vertical_input = 0.0 
var horizontal_input = 0.0

## Can be used to decide animation direction if key input is null.
var last_horizontal_input := 0.0

func process_input():
	vertical_input = Input.get_axis("human_move_up", "human_move_down") ## The horizontal direction toward which the player is moving.
	horizontal_input = Input.get_axis("human_move_left", "human_move_right") ## The horizontal direction toward which the player is moving.
	
	if horizontal_input:
		last_horizontal_input = horizontal_input
