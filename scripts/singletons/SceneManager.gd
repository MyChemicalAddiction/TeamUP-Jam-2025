extends Node

"""
The scene manager singleton delegates scene switching functionality to a main
scene.
"""

## Holds the current scene so it can be reset.
var current_scene: PackedScene

## Caught by all nodes that need to know when the scene is changing
signal loading_scene
 
## Caught by the main node
signal change_scene(new_scene: PackedScene)

func transition_to_scene(new_scene: PackedScene): # For transitioning the player's location to a different scene
	current_scene = new_scene
	
	change_scene.emit(current_scene)
	loading_scene.emit()

func reset_scene():
	change_scene.emit(current_scene)
