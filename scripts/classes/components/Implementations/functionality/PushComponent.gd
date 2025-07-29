extends Component
class_name PushComponent

"""
The PushComponent implements functionality for pushing rigid bodies in the path
of a given CharacterBody.

This can be used, for example, to let the players push boxes out of the way.
"""

@export var object: CharacterBody2D ## The thing that should be able to push things
@export var push_force := 0.05 ## How strong the pushing force is

func process_physics(_delta: float) -> void:
	if enabled:
		for i in object.get_slide_collision_count():
			var c = object.get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
