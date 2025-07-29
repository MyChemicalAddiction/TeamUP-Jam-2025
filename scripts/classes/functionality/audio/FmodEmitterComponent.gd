extends FmodEventEmitter2D
class_name FmodEmitterComponent

"""
Implements a bit of the Component interface to communicate with components.
"""

@export var component: Component
@export var on_use := false ## If this should be played when the component is used.

func _ready():
	if on_use:
		component.used.connect(play)
