extends InputState
class_name ThrowingState

@export var thrownState: State
@export var heldState: State

"""
The state the amulet is in whilst being thrown. In this state, the correct
velocity & direction that will be applied to the throwing force upon release
of the throwing button (LMB by default) is calculated. When the button is
released, the state should transition to the ThrownState.

Whilst in this state, the amulet moves with the player.

Upon being entered, this state might emit a corresponding signal that can maybe
in the future communicate to an AnimationPlayer observer that causes the
human to look like he's throwing something when the signal is received.
"""
