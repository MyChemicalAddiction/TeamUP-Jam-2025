extends InputState
class_name ThrowingState

"""
The state the amulet is in whilst being thrown. In this state, the correct
velocity & direction that will be applied to the throwing force upon release
of the throwing button (LMB by default) is calculated. When the button is
released, the state should transition to the ThrownState.

Whilst in this state, the amulet moves with the player.

Upon being entered, this state might emit a corresponding signal that can maybe
in the future communicate to an AnimationPlayer observer that causes the
human to look like he's throwing something when the signal is received.
"""

@export var holder: Character ## References the Human - which "holds" the amulet, meaning the amulet's position at the start of the throw must be at the center of the human

@export var thrownState: State
@export var heldState: State

var charging := false ## Whether the player is currently holding down LMB to charge the amulet.
var cancel := false ## When the player is charging the amulet throw, he can optionally RMB click to cancel the throw (reflected in this variable).
var mouse_pos := Vector2.ZERO ## The position of the mouse cursor (used to calculate the direction of the force applied to the amulet)>

var direction := Vector2.ZERO ## The direction toward which the force will be applied.
var min_force := 0.1
var max_force := 1.0

func enter(): ## Overridden here to fix an annoying visual defect where the arrow toward which the player is throwing something is oriented wrong on the first frame.
	input_manager.process_input()

	mouse_pos = input_manager.mouse_pos
	
	entered.emit()
	
	_on_enter()

func _on_enter():
	print('throwing!')

func _on_exit():
	object.freeze = false
	
	object.position = holder.position
	object.visible = true
	
	direction = (mouse_pos - object.position).normalized()
	
	object.apply_central_impulse(Vector2(max_force, max_force) * direction)

func process_physics(_delta):
	pass

func process_input(_delta):
	input_manager.process_input()
	
	charging = input_manager.charging
	cancel = input_manager.cancel
	mouse_pos = input_manager.mouse_pos
	
	if cancel:
		return heldState
	
	if !charging:
		return thrownState
