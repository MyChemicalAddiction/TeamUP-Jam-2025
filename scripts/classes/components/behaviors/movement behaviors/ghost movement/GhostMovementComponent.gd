extends MovementComponent
class_name GhostMovementComponent 

const SPEED = 300.0
const ACCELERATE = 60.0
const JUMP_VELOCITY = -400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum MovementStates { ## For implementing the state pattern
	Idle,
	Walking,
	Jumping,
	Falling
}

var current_state: MovementStates

func _ready():
	call_deferred('_change_state', MovementStates.Idle)

func _handle_movement(delta):
	var vertical_input = Input.get_axis("ghost_move_up", "ghost_move_down") ## The horizontal direction toward which the player is moving.
	var horizontal_input = Input.get_axis("ghost_move_left", "ghost_move_right") ## The horizontal direction toward which the player is moving.
	
	match current_state:
		MovementStates.Falling:
			character.velocity.x = move_toward(character.velocity.x, SPEED * horizontal_input, ACCELERATE)
			character.velocity.y += gravity * delta
			if character.is_on_floor():
				_change_state(MovementStates.Idle)
				return
			if vertical_input < 0:
				_change_state(MovementStates.Jumping)
			
		MovementStates.Idle:
			character.velocity.x = move_toward(character.velocity.x, 0, ACCELERATE)
			if not character.is_on_floor():
				_change_state(MovementStates.Falling)
				return
			if horizontal_input:
				_change_state(MovementStates.Walking)
				return
			if vertical_input < 0:
				_change_state(MovementStates.Jumping)
				
		MovementStates.Walking:
			if horizontal_input:
				character.velocity.x = move_toward(character.velocity.x, SPEED * horizontal_input, ACCELERATE)
			else:
				_change_state(MovementStates.Idle)
				return
			if not character.is_on_floor():
				_change_state(MovementStates.Falling)
				return
			if vertical_input < 0:
				_change_state(MovementStates.Jumping)
				
		MovementStates.Jumping:
			if vertical_input < 0:
				character.velocity.y = move_toward(character.velocity.y, JUMP_VELOCITY, ACCELERATE)
			else:
				character.velocity.y += gravity * delta
			character.velocity.x = move_toward(character.velocity.x, SPEED * horizontal_input, ACCELERATE)
			if character.velocity.y >= 0:
				_change_state(MovementStates.Falling)
	
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
			character.velocity.y = 0
		MovementStates.Walking:
			pass
