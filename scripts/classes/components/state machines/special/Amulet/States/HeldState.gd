extends InputState
class_name HeldState

"""
The state the amulet is in when in the player's hand. From here, it can tran-
sition to the ThrowingState. Whilst held, the amulet moves with the human.

When entered, this state makes the amulet invisible.
"""

@export var throwingState: State 

## The human.
@onready var holder = get_tree().get_first_node_in_group("Human")

## Whether the player is currently holding down LMB to charge the amulet.
var charging := false 

func _on_enter():
	object.visible = false
	object.freeze = true 

func _on_exit():
	pass

func process_physics(_delta):
	object.position = holder.position

func process_input(_delta):
	input_manager.process_input()
	
	charging = input_manager.charging
	if charging:
		return throwingState
