extends Node2D
class_name Component

"""
The Component superclass provides a common interface for enabling/disabling
behavior of a component.
"""

@export var enabled = true

signal on_enabled
signal on_disabled

## A node that, when used, enables this one. This is typically assigned an InteractionArea node but can also be assigned another Functional Component, too, since they also emit this signal (polymorphism W).
@export var enabler: Node 

## A node that, when disabled/enabled, disables/enables this one, too.
@export var enable_manager: Node 

func _ready():
	if enabler and enabler != self:
		enabler.used.connect(enable)
	if enable_manager:
		enable_manager.on_disable.connect(disable)
		enable_manager.on_enable.connect(enable)
	if enabled:
		enable()
	else:
		disable()

func enable(): ## Sets enabled variable to true & triggers any extra relevant implementation-defined behavior.
	enabled = true
	on_enabled.emit()
	_on_enable()

func disable(): ## Sets enabled variable to false & triggers any extra relevant implementation-defined behavior.
	enabled = false
	on_disabled.emit()
	_on_disable()

func _on_disable(): ## Hook for extra behavior on disabling.
	pass
	
func _on_enable(): ## Hook for extra behavior on enabling.
	pass
