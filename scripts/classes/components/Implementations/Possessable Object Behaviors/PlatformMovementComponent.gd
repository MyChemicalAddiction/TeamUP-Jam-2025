extends Component
class_name PlatformMovementComponent

"""
Encapsulates behavior for the ghost moving a possessed platform.

When enabled, it executes a continuous process (namely - moving the platform 
based on the player's inputs).

It gets enabled when the area owner gets interacted with, and disabled when the
area's disable() function is called.
"""

@export var object: Node ## The object to be moved (platform).
@export var input_manager: InputManager
@export var SPEED: int = 500

func _on_enable():
	set_physics_process(true)

func _on_disable():
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	input_manager.process_input()
	
	object.velocity = Vector2(input_manager.horizontal_input * SPEED, input_manager.vertical_input * SPEED)
	object.move_and_slide()
