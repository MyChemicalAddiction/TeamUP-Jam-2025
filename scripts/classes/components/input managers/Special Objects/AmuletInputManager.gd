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

func process_input():
	pass
