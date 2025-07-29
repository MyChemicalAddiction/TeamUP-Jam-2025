extends FmodEventEmitter2D
class_name FmodEmitterComponent

"""
Implements a bit of the Component interface to communicate with components.
"""

@export var component: Component
@export var duck_typed_component: Node
@export var on_use := false ## If this should be played when the component is used.
@export var on_enable := false

func _ready():
	if on_use:
		if component:
			component.used.connect(play)
	if duck_typed_component:
		if on_enable:
			duck_typed_component.on_enabled.connect(play)
			duck_typed_component.on_disabled.connect(stop)
