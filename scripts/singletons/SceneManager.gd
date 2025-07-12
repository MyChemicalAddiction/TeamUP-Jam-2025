extends Node

"""
The scene manager singleton delegates scene switching functionality to
main_scene.
"""

## The scene to which scene changing behavior is delegated
var main_scene: Node

## Emitted after the screen goes black and the game starts loading a new level scene.
signal loading_scene 

func transition_to_scene(new_scene: String, loading=false): ## For transitioning to a different scene
	loading_scene.emit()
	main_scene.transition_to_scene(new_scene, loading)

## resets the scene
func reset_scene():
	loading_scene.emit()
	main_scene.reset_scene()
