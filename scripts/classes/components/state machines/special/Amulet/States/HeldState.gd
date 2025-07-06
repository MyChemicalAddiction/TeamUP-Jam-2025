extends InputState
class_name HeldState

"""
The state the amulet is in when in the player's hand. From here, it can tran-
sition to the ThrowingState. Whilst held, the amulet moves with the human.

When entered, this state makes the amulet invisible.
"""

@export var throwingState: State 

var charging := false ## Whether the player is currently holding down LMB to charge the amulet.

func _on_enter():
	print('held!')
	object.visible = false
	object.freeze = true 

func _on_exit():
	pass

func process_physics(_delta):
	pass

func process_input(_delta):
	input_manager.process_input()
	
	charging = input_manager.charging
	if charging:
		return throwingState
	
	#object.position = mouse_pos
