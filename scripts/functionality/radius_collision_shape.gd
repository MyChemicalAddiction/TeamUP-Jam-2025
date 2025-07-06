extends CollisionPolygon2D
class_name RadiusCollisionShape2D

@export var circle_density := 3 ## How many points should the circle be made of?
@export var circle_radius := 1 ## How wide should the circle be?

func _ready() -> void:
	var points := PackedVector2Array()
	var angle_step := TAU / circle_density
	
	for i in range(circle_density):
		var angle: float = i * angle_step
		var point: Vector2 = Vector2(cos(angle), sin(angle)) * circle_radius
		points.append(point)
	
	polygon = points
	build_mode = CollisionPolygon2D.BUILD_SEGMENTS
