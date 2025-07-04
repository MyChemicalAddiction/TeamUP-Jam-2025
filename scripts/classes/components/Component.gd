extends Node2D
class_name Component

"""
The Component superclass provides a common interface for enabling/disabling
behavior of a component.
"""

@export var enabled = true

func enable(): ## Sets enabled variable to true & triggers any extra relevant implementation-defined behavior.
	enabled = true
	_on_enable()

func disable(): ## Sets enabled variable to false & triggers any extra relevant implementation-defined behavior.
	enabled = false
	_on_disable()

func _on_disable(): ## Hook for extra behavior on disabling.
	pass
	
func _on_enable(): ## Hook for extra behavior on enabling.
	pass
