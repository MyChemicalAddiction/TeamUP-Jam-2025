extends FmodEventPlayer
class_name FmodCutsceneEventPlayer

@onready var cutscene_player = get_parent()

@export var enabled := true

func _ready() -> void:
	if enabled:
		super()
		cutscene_player.fading_in.connect(_toggle)
		cutscene_player.fading_out.connect(_untoggle)

func _toggle():
	event.start()
		
func _untoggle():
	event.stop(1)
