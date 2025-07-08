extends InputManager
class_name HumanInteractInputManager

"""
Manages input for the human's HumanInteractInputManager.
"""

var pressed_interact := false

func process_input():
	pressed_interact = Input.is_action_just_pressed("human_interact")
