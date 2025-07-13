extends InputManager
class_name AmuletInputManager

"""
The AmuletInputManager manages (detects) mouse player (human) input as to
communicate it to the amulet's state machine's ThrowingState so that *it*
can properly calculate in which direction and how far the amulet should be
thrown upon release of the mouse.

Holding down LMB - charges the amulet.
Phyiscally moving the mouse in some direction - changes where the amulet's
trajectory is headed if thrown.
Releasing LMB - throws the amulet.
Clicking RMB whilst holding down LMB - cancels the throw.
"""

var charging := false ## Whether the player is currently holding down LMB to charge the amulet.
var cancel := false ## When the player is charging the amulet throw, he can optionally RMB click to cancel the throw (reflected in this variable).
var cancelled := false ## After the player cancels, he will still be holding the charging button down for a bit before releasing it. To prevent the state machine from perceiving this as going immediately back to charging upon cancelling, this variable keeps track of whether a cancel has ocurred.
var mouse_pos := Vector2.ZERO ## The position of the mouse cursor (used to calculate the direction of the force applied to the amulet)>
var retrieve_amulet := false ## When the player presses the key to retrieve the amulet (M)

func process_input():
	charging = Input.is_action_pressed("amulet_throw")
	
	cancel = Input.is_action_just_pressed("cancel_throw")
	
	retrieve_amulet = Input.is_action_just_pressed("retrieve_amulet")
	
	if cancel and charging:
		cancelled = true
	
	if cancelled:
		if charging:
			charging = false
		else:
			cancelled = false
			
	mouse_pos = get_viewport().get_mouse_position()
	mouse_pos = get_viewport().get_canvas_transform().affine_inverse() * mouse_pos
