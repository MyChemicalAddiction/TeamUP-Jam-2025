extends InputManager
class_name GhostPlatformInputManager

"""
Encapsulates input logic for horizontal possessable platforms.
"""

var horizontal_input := 0.0
var vertical_input := 0.0

@export var horizontal := false
@export var vertical := false

func process_input():
	if horizontal: horizontal_input = Input.get_axis("ghost_move_left", "ghost_move_right")
	if vertical: vertical_input = Input.get_axis("ghost_move_up", "ghost_move_down")
