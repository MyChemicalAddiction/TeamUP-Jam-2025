extends FmodPlayingStateListener

"""
Encapsulates logic for playing the SFX only if the falling velocity was big enough.
"""

@export var falling_velocity_treshold := 100

func _check_condition():
	return state.falling_velocity >= falling_velocity_treshold
