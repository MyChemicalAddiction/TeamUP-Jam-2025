extends MovementComponent
class_name HumanMovementComponent

const SPEED = 300.0
const JUMP_VELOCITY = -400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum MovementStates { ## For implementing the state pattern
	Idle,
	Walking,
	Jumping,
	Falling
}

var current_state: MovementStates

func _handle_movement(delta):
	var vertical_input = Input.get_axis("human_move_up", "human_move_down") ## The horizontal direction toward which the player is moving.
	var horizontal_input = Input.get_axis("human_move_left", "human_move_right") ## The horizontal direction toward which the player is moving.

	if horizontal_input:
		_change_state(MovementStates.Walking)
	else:
		_change_state(MovementStates.Idle)
		
	if vertical_input and character.is_on_floor():
		_change_state(MovementStates.Jumping)
	
	if not character.is_on_floor():
		_change_state(MovementStates.Falling)
	
	match current_state:
		MovementStates.Falling:
			character.velocity.x = horizontal_input * SPEED
			character.velocity.y += gravity * delta
		MovementStates.Idle:
			character.velocity.x = move_toward(character.velocity.x, 0, SPEED)
		MovementStates.Walking:
			character.velocity.x = horizontal_input * SPEED
		MovementStates.Jumping:
			character.velocity.y = JUMP_VELOCITY
	
	character.move_and_slide()
	
func _change_state(state: MovementStates): ## Implements the state pattern
	current_state = state
	match current_state:
		## later, behavior on transition to certain states can be added here (like playing animations)
		MovementStates.Falling:
			pass
		MovementStates.Jumping:
			pass
		MovementStates.Idle:
			pass
		MovementStates.Walking:
			pass
