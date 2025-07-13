extends Component
class_name HurtboxDestroyedBehavior

"""
The HurtboxDestroyedBehavior is implemented to define behavior local to the 
Hurtbox that it's assigned to that should be triggered when the Hurtbox is 
destroyed (its HP reaches 0.)
"""

## Assign the hitbox here. When this hitbox is hit, this behavior will be triggered.
@onready var hurtbox := get_parent() 

func _ready():
	hurtbox.destroyed.connect(destroyed)

func destroyed(): ## Triggered when the Hitbox hits something.
	if enabled:
		_on_destroyed()

func _on_destroyed(): ## Override to define behavior.
	pass
