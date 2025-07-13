extends FunctionalComponent
class_name FinishDoorComponent

"""
Encapsulates logic for a door at the end of a level that switches to the next
level when used.
"""

## The level entered when this is used.
@export var next_level_scene: PackedScene

func _on_use():
	SceneManager.transition_to_scene(next_level_scene)
