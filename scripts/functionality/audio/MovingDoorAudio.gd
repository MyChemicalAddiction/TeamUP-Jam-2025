extends FmodEventEmitter2D

"""
Encapsulates logic for playing SFX of moving vertical/horizontal doors:
	-plays the (looping) event when moving;
	-stop the event when movement is stopped.
"""

@export var door_component: MovingDoorComponent

func _ready():
	SceneManager.loading_scene.connect(queue_free)
	
	door_component.stopped_signal.connect(on_stopped)
	door_component.moving_signal.connect(on_moving)



func on_stopped():
	print('stopped')
	stop()

func on_moving():
	play()
	print('playing')
