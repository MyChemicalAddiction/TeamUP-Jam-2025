extends CharacterBody2D
class_name Character

"""
The character superclass provides shared state & methods between the two
characters in the game: the human player and the ghost player. These include:
	-A movement_component: a state machine to which the character delegates 
	movement logic;
	-A shared _ready() function (for common things to do upon entering the 
	scene tree);
	-A shared _on_ready hook (that each character can implement for extra
	behavior besides the shared one on ready).
	-A shared _physics_process() function and a shared _process_physics() hook.
"""

@export var movement_component: InputStateMachine ## The component which handles player movement.

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_ready()

func _on_ready(): ## Hook method for extra behavior on ready (overridden by implementations).
	pass

func _physics_process(delta: float) -> void: ## Called every frame.
	movement_component.process_physics(delta)
	_process_physics(delta)

func _process_physics(_delta): ## Implementation-defined hook for behavior on physics process.
	pass
