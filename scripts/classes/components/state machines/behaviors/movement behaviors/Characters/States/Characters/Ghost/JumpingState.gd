extends CharacterJumpingState
class_name GhostJumpingState

"""
The GhostJumpingState allows the ghost to jump (fly) by holding the jump button
rather than pressing it like the Human.
"""

@export var SPEED = 300.0
@export var ACCELERATE = 60.0
@export var JUMP_VELOCITY = -400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var vertical_input = 0.0
var horizontal_input = 0.0

func process_input(_delta):
	input_manager.process_input()
	vertical_input = input_manager.vertical_input
	horizontal_input = input_manager.horizontal_input
	object.velocity.x = move_toward(object.velocity.x, SPEED * horizontal_input, ACCELERATE)

func process_physics(delta: float):
	if vertical_input < 0:
		object.velocity.y = move_toward(object.velocity.y, JUMP_VELOCITY, ACCELERATE)
	
	else:
		object.velocity.y += gravity * delta
	
	object.move_and_slide()
	
	if object.velocity.y > 0:
		return FallingState

func _on_enter():
	pass

func _on_exit():
	pass
