extends InputState
class_name ThrownState

@export var heldState: State

"""
The state the amulet is in upon being thrown (in this state, it is out of the
human's hands and can maybe be retrieved).
"""

func _on_enter():
	pass

func _on_exit():
	pass

func process_physics(_delta):
	pass

func process_input(_delta):
	pass
