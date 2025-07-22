extends CanvasLayer

func _unhandled_key_input(_event: InputEvent) -> void:
	queue_free()
