extends HurtboxHitBehavior
class_name HurtboxSimpleDamageHitBehavior

"""
A simple implementation of the HurtboxHitBehavior that causes the hurtbox
to take the damage as defined in the Hitbox's resource.
"""

func _on_hit(damage, _knockback): ## Override to define behavior.
	hurtbox.damage(damage)
