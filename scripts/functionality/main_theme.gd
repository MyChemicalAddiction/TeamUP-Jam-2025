extends FmodEventEmitter2D

@export var menu: Control

func _ready():
	SceneManager.loading_scene.connect(_on_menu_untoggled)
	
	menu.toggled.connect(_on_menu_toggled)
	menu.untoggled.connect(_on_menu_untoggled)

func _on_menu_toggled():
	enable()

## TODO: this is a janky workaround for not being able to pause events from an eventemitter node. maybe fix later??
func _on_menu_untoggled():
	disable()

func enable():
	volume = 1.0
	play()

func disable():
	volume = 0.0
