class_name FunctionalComponent
extends Component

"""
A functional component is a modular object that has some distinct functionality and 
is meant to be re-used across the game. 

All functional components can know about a triggerer (often a
InteractionArea), so that its used signal can be connected to
this component's use function.

Alternatively, components may be connected to [b]each other[/b], such that
one provides an additional functionality for another.

TLDR: the interface for implementing a functional component is to:
	1) override the _on_use() function to define use behavior;
	2) override the _on_ready() hook if necessary.
"""

@export var triggerer: Node ## A node that, when used, directly triggers this node's use function, too. This is typically assigned an InteractionArea node but can also be assigned another Functional Component, too, since they also emit this signal (polymorphism W).
@export var one_shot = false ## If true, deletes self upon use.
@export var area: Area2D ## The area that, when entered by another area (for example - by an InteractionManager's - which both players have), triggers this behavior.

signal used ## Emmitted when used.

func use(): ## The method used to trigger this component's function.
	if enabled:
		used.emit()
		if one_shot: queue_free()
		return _on_use() 
		
func _on_use(): ## ABSTRACT METHOD. The functionality of this component is defined here.
	push_error("Undefined abstract method at Functional component.")

func _ready(): ## Connects own on_use functionality with triggerer's used signal.
	super()
	if triggerer and triggerer != self: 
		triggerer.used.connect(use)
	if area:
		area.area_entered.connect(_on_area_entered)
	_on_ready()

func _on_area_entered(_obj):
	use()

func _on_ready(): ## Overriden method that adds behavior on ready.
	pass
