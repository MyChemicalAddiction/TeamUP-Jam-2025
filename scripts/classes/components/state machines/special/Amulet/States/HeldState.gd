extends InputState
class_name HeldState

@export var throwingState: State

"""
The state the amulet is in when in the player's hand. From here, it can tran-
sition to the ThrowingState. Whilst held, the amulet moves with the human.

When entered, this state makes the amulet invisible.
"""
