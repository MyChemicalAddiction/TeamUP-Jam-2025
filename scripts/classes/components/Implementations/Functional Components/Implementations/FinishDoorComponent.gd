extends FunctionalComponent
class_name FinishDoorComponent

"""
Encapsulates logic for a door at the end of a level that switches to the next
level when used.
"""

## The path to the level entered when this is used.
@export var next_level_scene_path: String

## The level entered when this is used.
@onready var next_level_scene: PackedScene = load(next_level_scene_path)

func _on_use():
	SceneManager.transition_to_scene(next_level_scene)
