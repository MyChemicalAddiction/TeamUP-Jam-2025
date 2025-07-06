extends InputState
class_name ThrownState

@export var heldState: State
@export var holder: Character ## The human player.

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
	input_manager.process_input()
	if input_manager.retrieve_amulet:
		object.global_position = holder.global_position
		return heldState
