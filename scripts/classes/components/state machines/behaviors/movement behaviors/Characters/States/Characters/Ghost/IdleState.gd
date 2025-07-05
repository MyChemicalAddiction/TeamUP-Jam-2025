extends CharacterIdleState
class_name GhostIdleState

@export var ACCELERATE = 60.0

func process_input(delta):
	input_manager.process_input()
	if input_manager.horizontal_input:
		return WalkingState
	if input_manager.vertical_input < 0:
		return JumpingState
		
func process_physics(delta: float):
	object.velocity.x = move_toward(object.velocity.x, 0, ACCELERATE)
	if not object.is_on_floor():
		return FallingState
			
	object.move_and_slide()

func enter():
	object.velocity.y = 0

func exit():
	pass
