extends CharacterFallingState
class_name HumanFallingState

"""
The human player falls normally.
"""

@export var SPEED = 300.0
@export var ACCELERATE = 60.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var horizontal_input = 0.0
var vertical_input = 0.0

func process_input(_delta):
	input_manager.process_input()
	vertical_input = input_manager.vertical_input
	horizontal_input = input_manager.horizontal_input ## The horizontal direction toward which the player is moving.
	
func process_physics(delta: float):
	object.velocity.x = move_toward(object.velocity.x, SPEED * horizontal_input, ACCELERATE)
	object.velocity.y += gravity * delta
	if object.is_on_floor():
		return IdleState
		
	object.move_and_slide()

func _on_enter():
	pass

func _on_exit():
	pass
