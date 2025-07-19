extends Component
class_name PlatformMovementComponent

@export var object: CharacterBody2D ## The platform's node (that should be moved)
@export var move_speed: float = 100.0 ## The speed at which the platform moves.
@export var collision_detector: Area2D ## Detects collisions with walls/ceilings to know when to switch direction.

var current_speed := 0.0

@export_enum("horizontal", "vertical") var type ## Whether this should move horizontally or vertically.

func switch_direction(_body):
	current_speed *= -1
	if type: object.velocity.y = current_speed
	else: object.velocity.x = current_speed

func _ready():
	collision_detector.body_entered.connect(switch_direction)
	
	if !type:
		object.velocity.x = move_speed
		current_speed = object.velocity.x
	else:
		object.velocity.y = move_speed
		current_speed = object.velocity.y

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	object.move_and_slide()
