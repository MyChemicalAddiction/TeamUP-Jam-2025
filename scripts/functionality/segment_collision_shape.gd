extends CollisionShape2D

var target_area: Node = null

@onready var segment := shape.duplicate() as SegmentShape2D
@onready var original_b := segment.b

@export var area_tracker: AreaEnteredTrackerComponent
@export var line: Line2D

@export var dot: CollisionShape2D

func _ready():
	shape = segment
	
	line.points[1] = segment.b
	
	area_tracker.connect("area_entered", _on_area_entered)
	area_tracker.connect("area_empty", _on_area_exited)
	set_physics_process(false)

func _on_area_entered() -> void:
	set_physics_process(true)

func _on_area_exited() -> void:
	target_area = null
	segment.b = original_b
	line.points[1] = segment.b
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	area_tracker.sort_areas_by_distance()
	target_area = area_tracker.active_areas[0]

	var to_target_global = target_area.global_position - global_position
	
	var to_target_local = to_local(global_position + to_target_global)

	var direction = original_b.normalized()
	var max_length = original_b.length()

	# Project the vector onto the original direction
	var projected_length = direction.dot(to_target_local)
	projected_length = clamp(projected_length, 0.0, max_length)

	# Update the segment along original orientation
	segment.b = direction * projected_length
	line.points[1] = segment.b
	
	dot.position = segment.b
