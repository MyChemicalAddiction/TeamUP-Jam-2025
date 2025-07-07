extends Area2D
class_name InteractionArea

"""
The Interaction Area is a node you can add to any scene to make it interactable by the player.
Make sure the collision mask for the object matches the layer for the player (2).
"""

@export var action_name: String = "interact"

var interact: Callable = func():
	pass

func _on_body_entered(body) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(body) -> void:
	InteractionManager.unregister_area(self)
