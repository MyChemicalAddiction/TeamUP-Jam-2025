extends InputManager
class_name HorizontalPlatformInputManager

"""
Encapsulates input logic for horizontal possessable platforms.
"""

var horizontal_input := 0.0
var vertical_input := 0.0

func process_input():
	horizontal_input = Input.get_axis("ghost_move_left", "ghost_move_right")
