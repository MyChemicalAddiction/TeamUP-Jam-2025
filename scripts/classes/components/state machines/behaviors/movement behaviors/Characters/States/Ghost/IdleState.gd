extends InputState
class_name GhostIdleState

@export var ACCELERATE = 60.0

@export var WalkingState: InputState
@export var JumpingState: InputState
@export var FallingState: InputState
@export var HiddenState: InputState

## References the state machine so this state can force a change to self in the event of a level reset.
@onready var state_machine = get_parent()

func _ready():
	SceneManager.loading_scene.connect(reset)

func reset():
	state_machine.change_state(self)

func process_input(_delta):
	input_manager.process_input()
	if input_manager.toggle_amulet:
		return HiddenState
	if input_manager.horizontal_input:
		return WalkingState
	if input_manager.vertical_input < 0:
		return JumpingState
		
func process_physics(_delta: float):
	object.velocity.x = move_toward(object.velocity.x, 0, ACCELERATE)
	if not object.is_on_floor():
		return FallingState
			
	object.move_and_slide()

func _on_enter():
	object.velocity.y = 0

func _on_exit():
	pass
