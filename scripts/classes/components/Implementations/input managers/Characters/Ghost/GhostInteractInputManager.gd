extends InputManager
class_name GhostInteractInputManager

"""
Manages input for the ghost's HumanInteractInputManager.
"""

var pressed_interact := false

func process_input():
	pressed_interact = Input.is_action_just_released("ghost_interact")
