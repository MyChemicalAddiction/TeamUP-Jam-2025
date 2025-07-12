extends HurtboxDestroyedBehavior
class_name HurtboxDestroyedLevelResetBehavior

"""
Resets the current level when destroyed.
"""

## Since we want the level to restart when any character dies, this behavior implementations makes that happen.
func _on_destroyed():
	SceneManager.reset_scene()
