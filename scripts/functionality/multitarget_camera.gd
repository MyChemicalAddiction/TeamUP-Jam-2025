extends Camera2D

@export var move_speed = 30 # camera position lerp speed
@export var zoom_speed = 3.0  # camera zoom lerp speed
@export var min_zoom = 2.0  # camera won't zoom closer than this
@export var max_zoom = 0.5  # camera won't zoom farther than this
@export var margin = Vector2(400, 200)  # include some buffer area around targets

@export var targets: Array[Character] = []

@onready var screen_size = get_viewport_rect().size

## If true, will hide the ghost if its top node is not visible on the screen. The MultiTargetCamera must be added to the "camera" group for this to be able to be referenced.
@export var untrack_hidden = false

func _process(delta):
	if !targets:
		return

	var tracked_targets: Array[Character]
	for i in targets:
		if i.visible or !untrack_hidden:
			tracked_targets.append(i)

	# Keep the camera centered among all targets
	var p = Vector2.ZERO
	for target in tracked_targets:
		p += target.position
	
	p /= tracked_targets.size() 
	position = lerp(position, p, move_speed * delta)

	# Find the zoom that will contain all targets
	var r = Rect2(position, Vector2.ONE)
	for target in tracked_targets:
		r = r.expand(target.position)
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
	var z
	if r.size.x > r.size.y * screen_size.aspect():
		z = 1 / clamp(r.size.x / screen_size.x, max_zoom, min_zoom)
	else:
		z = 1 / clamp(r.size.y / screen_size.y, max_zoom, min_zoom)
	zoom = lerp(zoom, Vector2.ONE * z, zoom_speed * delta)


func add_target(t):
	if not t in targets:
		targets.append(t)

func remove_target(t):
	if t in targets:
		targets.erase(t)
