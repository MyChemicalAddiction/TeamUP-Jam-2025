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

var in_amulet_radius := true:
	get:
		return in_amulet_radius
	set(value):
		in_amulet_radius = value
		if value:
			entered_amulet_radius.emit()
		else:
			exited_amulet_radius.emit()

## Emitted when entering the amulet's radius
signal entered_amulet_radius

## Emitted when exiting the amulet's radius.
signal exited_amulet_radius

func _on_ready():
	pass

func _process_physics(_delta):
	pass
