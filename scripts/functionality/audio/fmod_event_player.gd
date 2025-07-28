extends Node2D

var isPlaying: bool = true
var event: FmodEvent = null

# Called when the node enters the scene tree for the first time.
func _ready():
	event = FmodServer.create_event_instance_with_guid("{14484f42-f195-44fd-9b3e-d309c5afefeb}")
	event.volume = 1.0
	event.start()
