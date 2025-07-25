"""
A component designed for managing freeing objects. 
You assign the object you need deleted to the export object variable.
"""

extends FunctionalComponent
class_name DeleteComponent

@export var objects: Array[Node] ## The objects that are to be deleted.

func _on_use(): ## TODO: remove the if usable from here; make usable an inherited attribute; wrap this function in a use() function in parent class
	_delete()

func _delete(): ## Deletes the object.
	for object in objects:
		object.queue_free()
	queue_free()
