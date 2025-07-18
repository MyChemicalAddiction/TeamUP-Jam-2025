extends Component
class_name MovingDoorComponent

"""
Implements behavior of doors that can be slid up/down (usually based on if a
button is being pressed).
"""

@export var object: Node ## The door that needs to move up/down
@export var MOVING_DISTANCE := 450 ## How far should the door move up/down
@export var MOVING_TIME := 0.6 ## THe time in seconds for the object to open/close

@onready var current_tween : Tween ## The current tween being used

@onready var closed_pos = object.position

var open_pos: Vector2

@export_enum("Vertical", "Horizontal") var orientation: int = 0

func _ready():
	super()
	if !orientation: open_pos = closed_pos - Vector2(0, MOVING_DISTANCE)
	else: open_pos = closed_pos - Vector2(MOVING_DISTANCE, 0)

func _on_enable():
	if current_tween: current_tween.kill()
	current_tween = self.create_tween()
	if orientation:
		current_tween.tween_property(object, "position", open_pos, MOVING_TIME * (abs(object.position.x - open_pos.x) / MOVING_DISTANCE))
	else:
		current_tween.tween_property(object, "position", open_pos, MOVING_TIME * (abs(object.position.y - open_pos.y) / MOVING_DISTANCE))
		
func _on_disable():
	if current_tween: current_tween.kill()
	current_tween = self.create_tween()
	if orientation:
		current_tween.tween_property(object, "position", closed_pos, MOVING_TIME * (abs(object.position.x - closed_pos.x) / MOVING_DISTANCE))
	else:
		current_tween.tween_property(object, "position", closed_pos, MOVING_TIME * (abs(object.position.y - closed_pos.y) / MOVING_DISTANCE))
