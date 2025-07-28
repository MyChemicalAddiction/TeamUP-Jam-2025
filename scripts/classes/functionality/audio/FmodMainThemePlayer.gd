extends FmodEventPlayer
class_name FmodMainThemePlayer

@export var menu: Control

func _ready():
	super()
	SceneManager.loading_scene.connect(_on_menu_untoggled)
	
	menu.toggled.connect(_on_menu_toggled)
	menu.untoggled.connect(_on_menu_untoggled)

func _on_menu_toggled():
	enable()

## TODO: this is a janky workaround for not being able to pause events from an eventemitter node. maybe fix later??
func _on_menu_untoggled():
	disable()

func enable():
	event.paused = false

func disable():
	event.paused = true
