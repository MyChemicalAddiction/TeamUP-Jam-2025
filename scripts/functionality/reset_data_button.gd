extends Button

@export var audio_player: FmodEventEmitter2D

func _ready():
	button_up.connect(reset)

## Emits the section_switch signal, caught by the top menu node
func reset():
	SaveLoad.reset_data()
	audio_player.play()
