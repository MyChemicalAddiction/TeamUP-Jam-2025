extends InputState
class_name GhostPossessingState

"""
The possessing state is active when the ghost is "posssessing" an object.
Possessable objects are in the group "Possessable" - this fact is checked by 
the ghost's InteractionManager, and, if true, sets this to be the active state
upon interaction with such an object.
"""

## The Possessing state listens to what kind of area the interaction manager interacts with - if it's a possessable area, this state is entered.
@export var interaction_manager: InteractionManager

## Needs to reference the state machine to force it to switch to this state when needed.
@onready var state_machine: StateMachine = get_parent()

## References the possessed area
var current_area: Area2D

## When depossessing, this state should be exited and the IdleState entered.
@export var idleState: State

## Describes whether the ghost can possess something. Set to false when the ghost is outside the amulet's radius.
var can_possess := true

## Stores the ghost's default collision mask so it can be disabled or enabled at will.
var default_ghost_collision_mask: int = -1

## keeps track of whether this is the current state.
var active := false

func _on_enter():
	active = true
	object.collision_mask = -1
	object.visible = false
	interaction_manager.can_interact = false

func _on_exit():
	active = false
	object.collision_mask = default_ghost_collision_mask
	object.visible = true
	interaction_manager.can_interact = true

func _ready():
	call_deferred('setup')
	
func setup():
	interaction_manager.interacted.connect(possess)
	object.exited_amulet_radius.connect(force_depossess)
	object.entered_amulet_radius.connect(enable_possess)
	default_ghost_collision_mask = object.collision_mask

## Possesses the area.
func possess(area):
	if can_possess:
		state_machine.change_state(self)
		current_area = area

func process_physics(_delta):
	if current_area:
		object.global_position = current_area.global_position

func process_input(_delta):
	input_manager.process_input()
	
	if input_manager.depossess:
		return idleState

func force_depossess():
	can_possess = false
	if active:
		state_machine.change_state(idleState)

func enable_possess():
	can_possess = true
