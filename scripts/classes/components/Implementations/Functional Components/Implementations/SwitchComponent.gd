extends FunctionalComponent
class_name SwitchComponent

"""
The SwitchComponent emits a on_enabled signal when used if it was disabled
at the time of using, or a on_disabled signal if it was enabled at the time 
of using.

This effectively emulates pressing/lifting a lever - unlike the Continuous
Button, if this is used in implementing a lever, it need only be pressed once
to stay activated/deactivated.
"""

## Whether the lever is activated
@export var activated := false

func _on_ready():
	if !activated:
		on_disabled.emit()
	else:
		on_enabled.emit()

func _on_use():
	if activated:
		on_disabled.emit()
		activated = false
	else:
		on_enabled.emit()
		activated = true
