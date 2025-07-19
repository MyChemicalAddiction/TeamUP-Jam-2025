extends Component
class_name HorizontalPlatformMovementComponent

@export var object: CharacterBody2D ## The platform's node (that should be moved)
@export var move_speed: float = 100.0 ## The speed at which the platform moves.
@export var right_collision_detector: Area2D ## Detects collisions with walls/ceilings to know when to switch direction.
@export var left_collision_detector: Area2D ## Detects collisions with walls/ceilings to know when to switch direction.

var current_speed := 0.0

func switch_direction_right(_body):
	if current_speed < 0:
		current_speed *= -1
		object.velocity.x = current_speed
		
func switch_direction_left(_body):
	if current_speed > 0:
		current_speed *= -1
		object.velocity.x = current_speed

func _ready():
	right_collision_detector.body_entered.connect(switch_direction_left)
	left_collision_detector.body_entered.connect(switch_direction_right)

	object.velocity.x = move_speed
	current_speed = object.velocity.x

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	object.move_and_slide()
