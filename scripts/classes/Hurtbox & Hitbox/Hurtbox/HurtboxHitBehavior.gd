extends Component
class_name HurtboxHitBehavior

"""
The HurtboxHitBehavior is implemented to define behavior local to the Hurtbox
that it's assigned to that should be triggered when the Hurtbox is hit.
"""

@export var hurtbox: Hurtbox ## Assign the hitbox here. When this hitbox is hit, this behavior will be triggered.

func _ready():
	hurtbox.hit.connect(hit)

func hit(damage, knockback): ## Triggered when the Hitbox hits something.
	if enabled:
		_on_hit(damage, knockback)

func _on_hit(_damage, _knockback): ## Override to define behavior.
	pass
