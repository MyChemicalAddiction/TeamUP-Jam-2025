extends Resource
class_name HitboxRes

"""
The HitboxRes holds state for a Hitbox component. Namely, the damage it should
do and the knockback it should inflict.
"""

@export var damage: float ## The damage this Hitbox [b]should[/b] do to a Hurtbox (but this is dependent on if the Hurtbox allows it, too).
@export var knockback: float ## The knockback this Hitbox [b]should[/b] do to a Hurtbox (but this is dependent on if the Hurtbox allows it, too).
