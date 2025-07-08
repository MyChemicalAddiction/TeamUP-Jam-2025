extends Character
class_name GhostCharacter

"""
The ghost character implements Character and provides functionality for the 
in-game ghost character.

The ghost belongs to collision layer 3 (which the amulet's radius
scans for and can use to restrict the ghost) and mask 1 (which is held by
all phyisics objects which both the human and ghost should
collide with like walls).
"""

func _on_ready():
	pass

func _process_physics(_delta):
	pass
