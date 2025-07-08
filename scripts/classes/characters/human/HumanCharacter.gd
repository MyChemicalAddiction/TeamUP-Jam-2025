extends Character
class_name HumanCharacter

"""
The human character implements Character and provides functionality for the 
in-game human character.

The human character belongs to layer 2 (the layer specific to the human alone)
and has mask 1 (which is held by all phyisics objects which both the human and 
ghost should collide with like walls).
"""

func _on_ready(): ## Hook method for extra behavior on ready (overridden by implementations).
	pass

func _process_physics(_delta):
	pass
