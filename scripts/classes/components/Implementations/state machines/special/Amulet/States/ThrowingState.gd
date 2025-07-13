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

## The human player.
@onready var holder = get_tree().get_first_node_in_group("Human")

@export var thrownState: State
@export var heldState: State

## The current tween being used. This is necessary to let the amulet be trown at varying speeds
@onready var current_tween: Tween 

## Whether the player is currently holding down LMB to charge the amulet.
var charging := false 

## When the player is charging the amulet throw, he can optionally RMB click to cancel the throw (reflected in this variable).
var cancel := false 

## The position of the mouse cursor (used to calculate the direction of the force applied to the amulet)
var mouse_pos := Vector2.ZERO 

var direction := Vector2.ZERO ## The direction toward which the force will be applied.
var min_force := 0.01
var max_force := 3.0

## 1.0 represents full force. 0 represents minimum force.
var force_multiplier := 0.0 

## The amount it takes to go from full force to max force.
var REV_TIME := 1.0 

func _ready():
	## INITIALIZING THE TWEEN:
	current_tween = self.create_tween()
	current_tween.kill()

## Overridden here to fix an annoying visual defect where the arrow toward which the player is throwing something is oriented wrong on the first frame.
func enter(): 
	input_manager.process_input()

	mouse_pos = input_manager.mouse_pos
	
	force_multiplier = 0.0
	
	entered.emit()
	
	_on_enter()

func _on_enter():
	current_tween = self.create_tween()
	
	current_tween.tween_property(self, "force_multiplier", 1.0, REV_TIME)
	current_tween.tween_callback(_rev_finished)
	
func _rev_finished():
	current_tween.kill()

func _on_exit():
	current_tween.kill()
	object.freeze = false
	
	object.visible = true
	
	direction = (mouse_pos - object.position).normalized()
	
	var applied_force = min_force + (max_force - min_force) * force_multiplier
	
	object.apply_central_impulse(Vector2(applied_force, applied_force) * direction)

func process_physics(_delta):
	object.position = holder.position

func process_input(_delta):
	input_manager.process_input()
	
	charging = input_manager.charging
	cancel = input_manager.cancel
	mouse_pos = input_manager.mouse_pos
	
	if cancel:
		return heldState
	
	if !charging:
		return thrownState
