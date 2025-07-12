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
@export var interaction_component: InteractionManager ## The component which handles player interaction.
@export var hurtbox_component: Hurtbox ## The hurtbox of the character.

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneManager.loading_scene.connect(reset_character)
	_on_ready()

## What should happen when the character gets "reset" - this happens when the game loads a new level or resets the level (the game currently resets the level when a character dies).
func reset_character():
	global_position = Vector2.ZERO
	hurtbox_component.reset()

func _on_ready(): ## Hook method for extra behavior on ready (overridden by implementations).
	pass

func _physics_process(delta: float) -> void: ## Called every frame.
	movement_component.process_physics(delta)
	_process_physics(delta)

func _process_physics(_delta): ## Implementation-defined hook for behavior on physics process.
	pass
