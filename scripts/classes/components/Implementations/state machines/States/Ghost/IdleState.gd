extends InputState
class_name GhostIdleState

@export var ACCELERATE = 45.0

@export var MovingState: InputState
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
	if input_manager.horizontal_input or input_manager.vertical_input:
		return MovingState
		
func process_physics(_delta: float):
	object.velocity.x = move_toward(object.velocity.x, 0, ACCELERATE)
	object.velocity.y = move_toward(object.velocity.y, 0, ACCELERATE)
			
	object.move_and_slide()

func _on_enter():
	pass

func _on_exit():
	pass
