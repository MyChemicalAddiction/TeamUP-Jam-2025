extends Area2D
class_name InteractionArea

"""
The Interaction Area is a node you can add to any scene to make it interactable 
by the player.

This is a superclass (it can be implemented for extra or more complex behavior),
but it can itself be instanced because it allows easy implementation of
simple non-conditional interactions via Functional Components (to which it
communicated the used signal.) To implement such simple behavior:
	1) Instance the InteractionArea (and give it a collision shape)
	2) Add desired Functional Component implementations as its children
	3) Set each Functional Component's Triggerer in the inspector to the
	Interaction Area instance.
	4) Now, whenever the InteractionArea is interacted with, it will emit
	the used() signal, which will be caught by every FunctionalComponent and
	trigger their behavior.
	
If you need more complex (conditional, perhaps) behavior, subclass the 
InteractionArea superclass and define its interact() function as desired.
You can give the subclass export references to components as to directly 
and precisely control their behavior in the interact() function.
"""

signal used() ## Emitted when the interaction area is interacted with.

func _ready(): ## Sets the InteractionArea's collision layer to be able to be detected by InteractionManagers (4)
	collision_layer = 4

func interact(): ## Called when the player interacts with this area.
	used.emit()
