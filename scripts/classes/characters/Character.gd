extends CharacterBody2D
class_name Character

"""
The character superclass provides shared state & methods between the two
characters in the game: the human player and the ghost player.
"""

@export var movement_component: MovementComponent ## The component which handles player movement.

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred('_setup_components') ## Sets up components after they enter the scene tree.
	
	_on_ready()

func _setup_components(): ## Sets up any components associated to the character.
	movement_component.character = self

func _on_ready(): ## Hook method for extra behavior on ready (overridden by implementations).
	pass
