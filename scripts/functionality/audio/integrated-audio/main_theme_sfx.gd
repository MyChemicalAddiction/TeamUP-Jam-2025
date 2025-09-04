extends AudioStreamPlayer

@export var menu: Control
@export var auto_play := true

var isPlaying: bool = true
func _ready():
	if auto_play:
		play()
		
	SceneManager.quit.connect(_on_quit)
	SceneManager.loading_scene.connect(_on_menu_untoggled)
	
	menu.toggled.connect(_on_menu_toggled)
	menu.untoggled.connect(_on_menu_untoggled)

func _on_menu_toggled():
	enable()

func _on_quit():
	play()

## TODO: this is a janky workaround for not being able to pause events from an eventemitter node. maybe fix later??
func _on_menu_untoggled():
	disable()

func enable():
	play()

func disable():
	stop()
