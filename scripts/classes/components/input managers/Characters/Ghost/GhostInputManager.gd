extends InputManager
class_name GhostInputManager

"""
The GhostInputManager is a concrete implementation of the InputManager and is 
meant to manage inputs that are to be used somehow by the Ghost character's
other components (or by it itself).
"""

var vertical_input
var horizontal_input

func process_input():
	vertical_input = Input.get_axis("ghost_move_up", "ghost_move_down") ## The horizontal direction toward which the player is moving.
	horizontal_input = Input.get_axis("ghost_move_left", "ghost_move_right") ## The horizontal direction toward which the player is moving.
	
