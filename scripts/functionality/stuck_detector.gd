extends Area2D

"""
The StuckDetector is an Area2D & it encapsulates logic for checking if the
ghost is stuck in a wall.

When the ghost's physical collision is active, this area scans for physics
bodies inside it. If it detects one, it first waits to see if the ghost gets
automatically stuck. If it doesn't, it disables the ghost's physical collision
until it doesn't detect any more bodies inside it. Then, it re-activates it.
"""

@export var physical_collision: CollisionShape2D
@export var area_entered_tracker_component: AreaEnteredTrackerComponent

@export var ghost_possessing_state : InputState
@export var ghost_hidden_state : InputState

@export var enabled := true

@onready var object = get_tree().get_first_node_in_group("Ghost")

var area_present := false

func _ready():
	ghost_possessing_state.entered.connect(disable)
	ghost_possessing_state.exited.connect(enable)
	
	ghost_hidden_state.entered.connect(disable)
	ghost_hidden_state.exited.connect(enable)
	
	ghost_hidden_state.exited.connect(check)
	
	get_tree().get_first_node_in_group("amulet_radius").on_enabled.connect(_on_amulet_radius_enabled)
	get_tree().get_first_node_in_group("amulet_radius").on_disabled.connect(_on_amulet_radius_disabled)
	
	area_entered_tracker_component.area_empty.connect(_on_area_empty)
	area_entered_tracker_component.area_present.connect(_on_area_present)

func _on_amulet_radius_disabled():
	if area_present:
		var max_attempts := 8
		var motion := Vector2(1, 0).rotated(randf() * TAU)  # random initial direction
		var distance := 4.0  # push distance per attempt

		for i in range(max_attempts):
			var test_motion := motion.rotated(i * TAU / max_attempts) * distance
			var result := PhysicsTestMotionResult2D.new()
			if not object.test_move(object.transform, test_motion, result):
				object.global_position += test_motion
				break

func _on_amulet_radius_enabled():
	pass

func _on_area_empty():
	if enabled:
		area_present = false

func _on_area_present():
	area_present = true

func disable():
	enabled = false

func enable():
	enabled = true

func check():
	pass
