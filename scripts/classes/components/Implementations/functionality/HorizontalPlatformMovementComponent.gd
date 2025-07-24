extends Component
class_name HorizontalPlatformMovementComponent

@export var object: CharacterBody2D ## The platform's node (that should be moved)
@export var move_speed: float = 100.0 ## The speed at which the platform moves.
@export var right_collision_detector: Node ## Detects collisions with walls/ceilings to know when to switch direction.
@export var left_collision_detector: Node ## Detects collisions with walls/ceilings to know when to switch direction.

var current_speed := 0.0
var queued_speed := 0.0

func switch_direction_right():
	if current_speed < 0:
		if !right_collision_detector.active_areas:
			current_speed *= -1
			object.velocity.x = current_speed
		else:
			queued_speed = current_speed * -1
			current_speed = 0
			object.velocity.x = 0
		
func switch_direction_left():
	if current_speed > 0:
		if !left_collision_detector.active_areas:
			current_speed *= -1
			object.velocity.x = current_speed
		else:
			queued_speed = current_speed * -1
			current_speed = 0
			object.velocity.x = 0

func resume_direction_right():
	if queued_speed > 0:
		current_speed = queued_speed
		object.velocity.x = current_speed
		queued_speed = 0

func resume_direction_left():
	if queued_speed < 0:
		current_speed = queued_speed
		object.velocity.x = current_speed
		queued_speed = 0

func _ready():
	right_collision_detector.area_entered.connect(switch_direction_left)
	left_collision_detector.area_entered.connect(switch_direction_right)
	
	right_collision_detector.area_empty.connect(resume_direction_right)
	left_collision_detector.area_empty.connect(resume_direction_left)

	object.velocity.x = move_speed
	current_speed = object.velocity.x

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	object.move_and_slide()
