extends InputState
class_name HumanIdleState

@export var WalkingState: InputState
@export var JumpingState: InputState
@export var FallingState: InputState

@export var push_component: PushComponent

@export var ACCELERATE = 60.0

@export var visual: AnimatedSprite2D

func process_input(_delta):
	input_manager.process_input()
	if input_manager.horizontal_input:
		return WalkingState
	if input_manager.vertical_input < 0:
		return JumpingState
		
func process_physics(_delta: float):
	object.velocity.x = move_toward(object.velocity.x, 0, ACCELERATE)
	if not object.is_on_floor():
		return FallingState
	
	object.move_and_slide()
	push_component.process_physics(_delta)

func _on_enter():
	visual.animation = "idle"
	object.velocity.y = 0

func _on_exit():
	pass
