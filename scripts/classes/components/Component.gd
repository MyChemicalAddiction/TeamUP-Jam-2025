extends Node2D
class_name Component

"""
The Component superclass provides a common interface for enabling/disabling
behavior of a component.
"""

@export var enabled = true

signal on_enabled
signal on_disabled

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
