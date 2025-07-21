extends FmodEventEmitter2D
class_name AudioPlayerComponent

"""
The AudioPlayerComponent implements an interface for communicating with the
Component & Functional Component APIs via their known signals.

This allows rudimentary audio playing to be connected to the enabling/disabling
of Component classes, as well as to the use of Functional Components.
"""

## The component to which this is tied.
@export var component: Component

## If this is audio is tied to a Component, whether it plays on its enable/disable depends on this variable. If it's a Functional Component, it again can play on disable/enable but also on use.
@export_enum("On Disable", "On Enable", "On Use") var mode

func _ready():
	match mode:
		0:
			component.on_disabled.connect(play)
		1:
			component.on_enabled.connect(play)
		2:
			component.used.connect(play)
