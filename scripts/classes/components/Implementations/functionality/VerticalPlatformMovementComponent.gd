extends Component
class_name VerticalPlatformMovementComponent

@export var object: CharacterBody2D ## The platform's node (that should be moved)
@export var move_speed: float = 100.0 ## The speed at which the platform moves.
@export var up_collision_detector: Area2D ## Detects collisions with walls/ceilings to know when to switch direction.
@export var down_collision_detector: Area2D ## Detects collisions with walls/ceilings to know when to switch direction.

var current_speed := 0.0

func switch_direction_up(_body):
	if current_speed > 0:
		current_speed *= -1
		object.velocity.y = current_speed
		
func switch_direction_down(_body):
	if current_speed < 0:
		current_speed *= -1
		object.velocity.y = current_speed

func _ready():
	up_collision_detector.body_entered.connect(switch_direction_down)
	down_collision_detector.body_entered.connect(switch_direction_up)

	object.velocity.y = move_speed
	current_speed = object.velocity.y

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	object.move_and_slide()
