extends FunctionalComponent
class_name PlatformMovementComponent

"""w
Encapsulates behavior for the ghost moving a possessed platform.
"""

@export var object: Node ## The object to be moved (platform).
@export var input_manager: InputManager
@export var SPEED: int = 500

func _on_enable():
	set_physics_process(true)

func _on_disable():
	set_physics_process(false)

func _on_ready():
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	input_manager.process_input()
	
	object.velocity = Vector2(input_manager.horizontal_input * SPEED, input_manager.vertical_input * SPEED)
	object.move_and_slide()
