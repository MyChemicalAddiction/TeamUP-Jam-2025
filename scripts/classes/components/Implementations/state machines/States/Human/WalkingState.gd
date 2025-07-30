extends InputState
class_name HumanWalkingState

@export var IdleState: InputState
@export var JumpingState: InputState
@export var FallingState: InputState

@export var SPEED = 300.0
@export var ACCELERATE = 60.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var vertical_input := 0.0
var horizontal_input := 0.0

@export var push_component: PushComponent

@export var visual: AnimatedSprite2D

## Used for coyote time
@export var coyote_timer : Timer
var falling

func _ready():
	super()
	coyote_timer.timeout.connect(fall)

func process_input(_delta):
	input_manager.process_input()
	horizontal_input = input_manager.horizontal_input
	vertical_input = input_manager.vertical_input
	
	if horizontal_input:
		object.velocity.x = move_toward(object.velocity.x, SPEED * horizontal_input, ACCELERATE)
	else:
		return IdleState
	
	visual.animation = 'left' if horizontal_input < 0 else 'right'
	
	if vertical_input < 0:
		return JumpingState

func fall():
	falling = true

func process_physics(_delta: float):
	if falling:
		falling = false
		return FallingState
		
	if not object.is_on_floor():
		if coyote_timer.is_stopped():
			coyote_timer.start()
		else:
			object.velocity.y += gravity * _delta
			
	else:
		coyote_timer.timeout.disconnect(fall)
		coyote_timer.stop()
		coyote_timer.timeout.connect(fall)
	
	object.move_and_slide()
	
	push_component.process_physics(_delta)

func _on_enter():
	pass

func _on_exit():
	pass
