extends InputState
class_name GhostMovingState

@export var SPEED = 400.0
@export var ACCELERATE = 60.0

@export var IdleState: InputState
@export var HiddenState: InputState

var vertical_input = Vector2.ZERO
var horizontal_input = Vector2.ZERO

func process_input(_delta):
	input_manager.process_input()
	
	if input_manager.toggle_amulet:
		return HiddenState
	
	horizontal_input = input_manager.horizontal_input
	vertical_input = input_manager.vertical_input
	
	if horizontal_input or vertical_input:
		object.velocity.x = move_toward(object.velocity.x, SPEED * horizontal_input, ACCELERATE)
		object.velocity.y = move_toward(object.velocity.y, SPEED * vertical_input, ACCELERATE)

	else:
		return IdleState
	
	object.move_and_slide()

func process_physics(_delta: float):
	pass

func _on_enter():
	pass

func _on_exit():
	pass
