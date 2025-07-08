extends HitboxHitBehavior
class_name HitboxHitDeleteBehavior

"""
Makes the holder of the hitbox be deleted when it hits a hurtbox.
"""

func _on_hit():
	hitbox.holder.queue_free()
