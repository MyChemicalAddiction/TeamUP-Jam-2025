extends AudioStreamPlayer

@onready var cutscene_player = get_parent()

func _ready() -> void:
	cutscene_player.visibility_changed.connect(_toggle)

func _toggle():
	if cutscene_player.visible:
		play()
	else:
		stop()
