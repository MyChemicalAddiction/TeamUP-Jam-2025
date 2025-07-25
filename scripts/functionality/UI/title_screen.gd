extends Control

func _ready() -> void:
	SceneManager.loading_scene.connect(queue_free)
