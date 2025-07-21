extends CanvasLayer

func _unhandled_key_input(event: InputEvent) -> void:
	queue_free()
