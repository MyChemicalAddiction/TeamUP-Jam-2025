extends State
class_name StaticAimedShooterShootingState

"""
Encapsulates behavior for when the static aimed shooter detects a hurtbox
present in its area and starts to shoot at it.
"""

## The area whose collision shape represents the radius in which the shooter can see entering characters.
@export var projectile_shooter: ProjectileShooter 

## The component that tracks entering areas.
@export var area_tracking_component: AreaEnteredTrackerComponent

## Once per how many seconds should this shoot?
@export var SHOOTING_RATE_SECONDS := 0.35 

@export var idleState: State

## References the state machine to force a change to self when a hurtbox enters the area's radius.
@onready var state_machine = get_parent()

func _ready():
	area_tracking_component.area_entered.connect(force_change_to_self)
	area_tracking_component.area_exited.connect(force_change_to_idle)

func force_change_to_self():
	if len(area_tracking_component.active_areas) == 1:
		state_machine.change_state(self)

func force_change_to_idle():
	if len(area_tracking_component.active_areas) == 0:
		state_machine.change_state(idleState)

## Hook for extra behavior when entered.
func _on_enter(): 
	pass

## Hook for extra behavior when exited.
func _on_exit(): 
	pass

## What this state should do every frame if it's active.
func process_physics(_delta):
	area_tracking_component.sort_areas_by_distance()
	projectile_shooter.look_at(area_tracking_component.active_areas[0].global_position)
