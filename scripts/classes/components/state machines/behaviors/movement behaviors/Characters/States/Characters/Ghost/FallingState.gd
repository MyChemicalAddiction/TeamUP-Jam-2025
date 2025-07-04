extends CharacterFallingState
class_name GhostFallingState

"""
The ghost's concrete implementation of the CharacterFallingState allows it to
jump (and thus fly) even when falling.
"""

const SPEED = 300.0
const ACCELERATE = 60.0
const JUMP_VELOCITY = -400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var horizontal_input = 0.0
var vertical_input = 0.0

func process_input(delta):
	input_manager.process_input()
	vertical_input = input_manager.vertical_input
	horizontal_input = input_manager.horizontal_input ## The horizontal direction toward which the player is moving.
	
func process_physics(delta: float):
	if object.velocity.y < 0:
		return JumpingState
	
	if vertical_input < 0:
		object.velocity.y = move_toward(object.velocity.y, JUMP_VELOCITY, ACCELERATE)
	
	else:
		object.velocity.y += gravity * delta
	
	object.velocity.x = move_toward(object.velocity.x, SPEED * horizontal_input, ACCELERATE)
	
	if object.is_on_floor():
		return IdleState
		
	object.move_and_slide()

func enter():
	pass

func exit():
	pass
