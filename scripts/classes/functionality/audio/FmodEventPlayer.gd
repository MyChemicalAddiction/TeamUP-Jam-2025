extends Node2D
class_name FmodEventPlayer

var isPlaying: bool = true
var event: FmodEvent = null

@export var event_GUID: String
@export var auto_play := true

# Called when the node enters the scene tree for the first time.
func _ready():
	event = FmodServer.create_event_instance_with_guid(event_GUID)
	event.volume = 1.0
	if auto_play:
		event.start()
