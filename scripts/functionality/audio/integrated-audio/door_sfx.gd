extends Node

"""
Encapsulates logic for playing SFX of moving vertical/horizontal doors:
	-plays the (looping) event when moving;
	-stop the event when movement is stopped.
"""

@export var door_component: MovingDoorComponent
@export_enum("Play on Moving", "Play on Stopped") var mode := 0

@export var audio_player: Node ## The node to which this delegates audio playing

## TODO: this is a janky workaround for preventing audio from playing at the beginning of the game. maybe fix later??
var timer = Timer.new()

var enabled := true

func _ready():
	timer.wait_time = 0.1
	timer.timeout.connect(enable)
	add_child(timer)
	disable()
	timer.start()
	
	SceneManager.loading_scene.connect(queue_free)

	door_component.stopped_signal.connect(on_stopped)
	door_component.moving_signal.connect(on_moving)

func on_stopped():
	if enabled:
		if !mode:
			audio_player.stop()
			return
		else:
			audio_player.play()

func on_moving():
	if enabled:
		if !mode:
			audio_player.play()
			return
		else:
			audio_player.stop()

func _notification(what):
	if what == NOTIFICATION_PAUSED:
		disable()
		audio_player.stop()
	elif what == NOTIFICATION_UNPAUSED:
		timer.start()

func enable():
	enabled = true

func disable():
	enabled = false
