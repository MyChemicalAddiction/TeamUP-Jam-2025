extends Component
class_name MovingDoorComponent

"""
Implements behavior of doors that can be slid up/down (usually based on if a
button is being pressed).
"""

@export var object: Node ## The door that needs to move up/down

@export var speed: float = 500 ## The speed at which this door opens/closes

var velocity: Vector2

@export_enum("Vertical", "Horizontal") var orientation: int = 0

@onready var closing_velocity: Vector2 = Vector2(0, speed) if !orientation else Vector2(-speed, 0) 
@onready var opening_velocity: Vector2 = Vector2(0, -speed) if !orientation else Vector2(speed, 0) 

@export var closing_collision_detector: AreaEnteredTrackerComponent ## Detects collisions with objects & players when closing to stop moving if something is in the way.
@export var opening_collision_detector: AreaEnteredTrackerComponent ## Detects collisions with objects & players wehn opening to stop moving if something is in the way.

signal moving_signal
signal stopped_signal

func _ready():
	super()
	
	closing_collision_detector.area_present.connect(closing_detector_entered)
	opening_collision_detector.area_present.connect(opening_detector_entered)
	
	closing_collision_detector.area_empty.connect(closing_detector_exited)
	opening_collision_detector.area_empty.connect(opening_detector_exited)

func opening_detector_entered():
	if enabled:
		stop()
		
func closing_detector_entered():
	if !enabled:
		stop()
		
func opening_detector_exited():
	if enabled:
		move()
		
func closing_detector_exited():
	if !enabled:
		move()
		
func _on_enable():
	velocity = opening_velocity
	if len(opening_collision_detector.active_areas) == 0:
		move()

func _physics_process(delta):
	object.move_and_collide(velocity * delta)
		
func _on_disable():
	velocity = closing_velocity
	if len(closing_collision_detector.active_areas) == 0:
		move()

func move():
	set_physics_process(true)
	moving_signal.emit()
	
func stop():
	set_physics_process(false)
	stopped_signal.emit()
	
