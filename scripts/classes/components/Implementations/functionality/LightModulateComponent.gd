extends Component
class_name LightModulateComponent

"""
Encapsulates functionality for tuning an overworld light's energy to one
of two levels (usually based on an EnableManager connection to another)
"""

@export var dim_energy := 0.0
@export var lit_energy := 1.0

@export var light: Node2D

func _on_enable():
	light.energy = lit_energy

func _on_disable():
	light.energy = dim_energy
