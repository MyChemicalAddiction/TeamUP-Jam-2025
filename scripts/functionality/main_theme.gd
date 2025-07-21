extends FmodEventEmitter2D

@export var menu: Control

func _ready():
	menu.level_selected.connect(queue_free)
