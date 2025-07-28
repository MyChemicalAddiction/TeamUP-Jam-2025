extends FunctionalComponent
class_name FinishDoorComponent

"""
Encapsulates logic for a door at the end of a level that switches to the next
level when used.
"""

## The path to the level entered when this is used.
@export var next_level_scene_path: String

## The path of the current level.
@export var current_level_path: String

## The level entered when this is used.
@onready var next_level_scene: PackedScene = load(next_level_scene_path)

func _on_use():
	SaveLoad.change_data('level_completed_data', current_level_path)
	
	CutscenePlayer.play_cutscene()
	
	#SceneManager.transition_to_scene(next_level_scene)
