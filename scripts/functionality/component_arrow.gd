extends Sprite2D

"""
Points toward the position of a Component's enablee.
"""

## The component towards whose enablee this points.
@export var component: Component

func _ready() -> void:
	component.enablee_set.connect(point)

func point(enablee):
	rotation = (enablee.global_position - global_position).angle()
