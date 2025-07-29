extends InputManager
class_name GhostPlatformInputManager

"""
Encapsulates input logic for horizontal possessable platforms.
"""

var horizontal_input := 0.0
var vertical_input := 0.0

@export var horizontal := false
@export var vertical := false

@export var right_collision_detector: Node ## Detects collisions with walls/ceilings to know when to switch direction.
@export var left_collision_detector: Node ## Detects collisions with walls/ceilings to know when to switch direction.

@export var up_collision_detector: Node ## Detects collisions with walls/ceilings to know when to switch direction.
@export var down_collision_detector: Node ## Detects collisions with walls/ceilings to know when to switch direction.

var up_enabled := false
var left_enabled := false
var right_enabled := false
var down_enabled := false

func _ready():
	if horizontal:
		left_enabled = true
		right_enabled = true
	if vertical:
		down_enabled = true
		up_enabled = true
	
	if up_collision_detector: 
		up_collision_detector.area_present.connect(disable_up)
		up_collision_detector.area_empty.connect(enable_up)
	if down_collision_detector:
		down_collision_detector.area_present.connect(disable_down)
		down_collision_detector.area_empty.connect(enable_down)
	if right_collision_detector: 
		right_collision_detector.area_present.connect(disable_right)
		right_collision_detector.area_empty.connect(enable_right)
	if left_collision_detector:
		left_collision_detector.area_present.connect(disable_left)
		left_collision_detector.area_empty.connect(enable_left)

func disable_up():
	up_enabled = false
func disable_down():
	down_enabled = false
func disable_left():
	left_enabled = false
func disable_right():
	right_enabled = false

func enable_left():
	left_enabled = true
func enable_right():
	right_enabled = true
func enable_up():
	up_enabled = true
func enable_down():
	down_enabled = true

func process_input():
	if horizontal:
		horizontal_input = Input.get_axis("ghost_move_left", "ghost_move_right")

		# Prevent movement in disabled directions
		if horizontal_input < 0.0 and not left_enabled:
			horizontal_input = 0.0
		elif horizontal_input > 0.0 and not right_enabled:
			horizontal_input = 0.0

	if vertical:
		vertical_input = Input.get_axis("ghost_move_up", "ghost_move_down")

		# Prevent movement in disabled directions
		if vertical_input < 0.0 and not up_enabled:
			vertical_input = 0.0
		elif vertical_input > 0.0 and not down_enabled:
			vertical_input = 0.0
