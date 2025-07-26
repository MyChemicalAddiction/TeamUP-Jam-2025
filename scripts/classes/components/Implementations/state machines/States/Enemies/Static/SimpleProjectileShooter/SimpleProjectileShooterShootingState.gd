extends State
class_name SimpleProjectileShooterShootingState

"""
Encapsulates behavior for a projectile shooter that shoots without aiming
when an area is entered.
"""

## The area whose collision shape represents the radius in which the shooter can see entering characters.
@export var projectile_shooter: ProjectileShooter 

## The component that tracks entering areas.
@export var area_tracking_component: AreaEnteredTrackerComponent

## Once per how many seconds should this shoot?
@export var SHOOTING_RATE_SECONDS := 0.2 

@export var idleState: State

## References the state machine to force a change to self when a hurtbox enters the area's radius.
@onready var state_machine = get_parent()

## Keeps track of the current tween 
@onready var current_tween: Tween
var elapsed_time: float = 0.0

func _ready():
	area_tracking_component.area_present.connect(force_change_to_self)
	area_tracking_component.area_empty.connect(force_change_to_idle)

func force_change_to_self():
	state_machine.change_state(self)

func force_change_to_idle():
	state_machine.change_state(idleState)

## Hook for extra behavior when entered.
func _on_enter(): 
	reset_tween()

## Hook for extra behavior when exited.
func _on_exit(): 
	current_tween.kill()

func reset_tween():
	projectile_shooter.use()
	elapsed_time = 0.0
	current_tween = self.create_tween()
	current_tween.tween_property(self, "elapsed_time", 1.0, SHOOTING_RATE_SECONDS)
	current_tween.tween_callback(reset_tween)
