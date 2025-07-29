extends AnimatedSprite2D

@export var input_manager: InputManager

func _ready():
	input_manager.input_changed.connect(_on_input_changed)

func _on_input_changed():
	if input_manager.horizontal_input > 0:
		animation = "right"
	elif input_manager.horizontal_input < 0:
		animation = "left"
