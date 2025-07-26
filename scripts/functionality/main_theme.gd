extends FmodEventEmitter2D

@export var menu: Control

func _ready():
	SceneManager.loading_scene.connect(_on_menu_untoggled)
	
	menu.toggled.connect(_on_menu_toggled)
	menu.untoggled.connect(_on_menu_untoggled)

func _on_menu_toggled():
	volume = 1.0
	play()

## TODO: this is a janky workaround for not being able to pause events from an eventemitter node. maybe fix later??
func _on_menu_untoggled():
	volume = 0.0
