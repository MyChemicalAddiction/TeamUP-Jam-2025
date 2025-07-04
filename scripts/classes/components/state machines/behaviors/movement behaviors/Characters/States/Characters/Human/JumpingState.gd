extends CharacterJumpingState
class_name HumanJumpingState

const SPEED = 300.0
const ACCELERATE = 60.0
const JUMP_VELOCITY = -400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var vertical_input = Vector2.ZERO
var horizontal_input = Vector2.ZERO

func process_input(delta):
	input_manager.process_input()
	vertical_input = input_manager.vertical_input
	horizontal_input = input_manager.horizontal_input
	object.velocity.x = move_toward(object.velocity.x, SPEED * horizontal_input, ACCELERATE)

func process_physics(delta: float):
	if object.velocity.y >= 0:
		return FallingState
	
	object.velocity.y += gravity * delta
	
	object.move_and_slide()

func enter():
	object.velocity.y = JUMP_VELOCITY

func exit():
	pass
