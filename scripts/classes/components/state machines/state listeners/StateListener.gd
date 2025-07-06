extends Component
class_name StateListener

"""
The StateListener listens for signals (mainly either entered or exited) from
States. It exploits godot built-in implementation of the observer pattern
(via "signals") to enable State-dependent (and that state can even be external!
as in, from another node than the one that parents the StateListener) behavior.
"""

@export var state: State ## The state to which this StateListener "listens" to

func _ready():
	call_deferred("_connect_state_signals")

func _connect_state_signals():
	state.exited.connect(_state_exited)
	state.entered.connect(_state_entered)

func _state_entered(): ## Called when the selected state is exited.
	if enabled:
		_on_state_entered()

func _state_exited(): ## Called when the selected state is entered.
	if enabled:
		_on_state_exited()
		
func _on_state_exited(): ## Overridden to provide behavior on the state being exited.
	pass

func _on_state_entered(): ## Overridden to provide behavior on the state being entered.
	pass
