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

func _on_enable():
	velocity = opening_velocity
	set_physics_process(true)

func _physics_process(delta):
	object.move_and_collide(velocity * delta)
		
func _on_disable():
	velocity = closing_velocity
	set_physics_process(true)
