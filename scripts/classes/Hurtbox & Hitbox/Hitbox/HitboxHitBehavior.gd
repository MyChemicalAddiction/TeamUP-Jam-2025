extends Component
class_name HitboxHitBehavior

"""
The HitboxHitBehavior is implemented to define behavior local to the Hitbox
that it's assigned to that should be triggered when the Hitbox hits something.
"""

@export var hitbox: Hitbox ## Assign the hitbox here. When this hitbox is hit, this behavior will be triggered.

func _ready():
	hitbox.hit.connect(hit)

func hit(): ## Triggered when the Hitbox hits something.
	if enabled:
		_on_hit()

func _on_hit(): ## Override to define behavior.
	pass
