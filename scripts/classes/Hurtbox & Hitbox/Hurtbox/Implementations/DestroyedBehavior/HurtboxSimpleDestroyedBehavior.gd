extends HurtboxDestroyedBehavior
class_name HurtboxSimpleDestroyedBehavior

"""
The HurtboxSimpleDestroyedBehavior makes the hurtbox's holder invisible.
"""

func _on_destroyed(): ## Override to define behavior.
	hurtbox.holder.visible = false
