extends FmodEventEmitter2D

@export var menu: Control

func _ready():
	SceneManager.loading_scene.connect(_on_menu_untoggled)
	
	menu.toggled.connect(_on_menu_toggled)
	menu.untoggled.connect(_on_menu_untoggled)

func _on_menu_toggled():
	volume = 1.0
	play()

func _on_menu_untoggled():
	volume = 0.0
