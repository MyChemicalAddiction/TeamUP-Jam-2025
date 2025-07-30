extends CollisionShape2D

var target_area: Node = null

@onready var segment := shape.duplicate() as SegmentShape2D

@onready var original_b := raycast.target_position

@export var line: Line2D
@export var raycast: RayCast2D

func _ready():
	shape = segment
	segment.b = original_b
	line.points[1] = segment.b

	raycast.enabled = true

	set_physics_process(true)

func _physics_process(_delta: float) -> void:
	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		var local_point = to_local(collision_point)

		# Clamp to original_b length to prevent overreach
		var direction = original_b.normalized()
		var projected_length = direction.dot(local_point)
		var clamped_length = clamp(projected_length, 0.0, original_b.length())
		segment.b = direction * clamped_length
	else:
		segment.b = original_b

	# Update visuals
	line.points[1] = segment.b
