extends CharacterJumpingState
class_name HumanJumpingState

@export var SPEED = 300.0
@export var ACCELERATE = 60.0
@export var JUMP_VELOCITY = -600.0
@export var JUMP_DECCELERATE = 0.85 ## The speed at which the vertical velocity deccelerates when the player releases the jump button (to enable varying-height jumps based on time the button is pressed).
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var vertical_input = Vector2.ZERO
var horizontal_input = Vector2.ZERO

func process_input(_delta):
	input_manager.process_input()
	vertical_input = input_manager.vertical_input
	horizontal_input = input_manager.horizontal_input
	object.velocity.x = move_toward(object.velocity.x, SPEED * horizontal_input, ACCELERATE)
	
	if vertical_input >= 0:
		object.velocity.y *= JUMP_DECCELERATE

func process_physics(delta: float):
	if object.velocity.y >= 0:
		return FallingState
	
	object.velocity.y += gravity * delta
	
	object.move_and_slide()

func _on_enter():
	object.velocity.y = JUMP_VELOCITY

func _on_exit():
	pass
