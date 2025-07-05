extends CharacterWalkingState
class_name GhostWalkingState

@export var SPEED = 300.0
@export var ACCELERATE = 60.0

var vertical_input = Vector2.ZERO
var horizontal_input = Vector2.ZERO

func process_input(delta):
	input_manager.process_input()
	horizontal_input = input_manager.horizontal_input
	vertical_input = input_manager.vertical_input
	
	if horizontal_input:
		object.velocity.x = move_toward(object.velocity.x, SPEED * horizontal_input, ACCELERATE)
	else:
		return IdleState

	if vertical_input < 0:
		return JumpingState
	
	object.move_and_slide()

func process_physics(delta: float):
	if not object.is_on_floor():
		return FallingState

func enter():
	pass

func exit():
	pass
