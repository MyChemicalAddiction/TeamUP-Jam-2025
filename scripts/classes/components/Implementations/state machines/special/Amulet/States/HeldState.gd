extends InputState
class_name HeldState

"""
The state the amulet is in when in the player's hand. From here, it can tran-
sition to the ThrowingState. Whilst held, the amulet moves with the human.

When entered, this state makes the amulet invisible.
"""

@export var throwingState: State 

## The visible image of the amulet.
@export var visual: Node 

## The human.
@onready var holder = get_tree().get_first_node_in_group("Human")

## Whether the player is currently holding down LMB to charge the amulet.
var charging := false 

## References the state machine so this state can force a change to self in the event of a level reset.
@onready var state_machine = get_parent()

## References the multi-target camera so that the ghost can be untracked when it's hidden in the amulet and the player is holding the amulet.
@onready var multitarget_camera = get_tree().get_first_node_in_group("camera")

func _ready():
	SceneManager.loading_scene.connect(reset)

func reset():
	state_machine.change_state(self)

func _on_enter():
	multitarget_camera.untrack_hidden = true
	visual.visible = false
	call_deferred('freeze_object')
	
func freeze_object():
	object.freeze = true 

func _on_exit():
	multitarget_camera.untrack_hidden = false

func process_physics(_delta):
	object.position = holder.position

func process_input(_delta):
	input_manager.process_input()
	
	charging = input_manager.charging
	if charging:
		return throwingState
