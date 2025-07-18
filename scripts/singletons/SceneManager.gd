extends Node

"""
The scene manager singleton delegates scene switching functionality to a main
scene.
"""

## Caught by all nodes that need to know when the scene is changing
signal loading_scene
 
## Caught by the main node
signal change_scene(new_scene: PackedScene)

func transition_to_scene(new_scene: PackedScene): # For transitioning the player's location to a different scene
	change_scene.emit(new_scene)
	loading_scene.emit()
