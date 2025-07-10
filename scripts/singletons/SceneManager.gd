extends Node

"""
The scene manager singleton delegates scene switching functionality to
main_scene.
"""

## The scene to which scene changing behavior is delegated
var main_scene: Node

func transition_to_scene(new_scene: String, loading=false): ## For transitioning to a different scene
	main_scene.transition_to_scene(new_scene, loading)
