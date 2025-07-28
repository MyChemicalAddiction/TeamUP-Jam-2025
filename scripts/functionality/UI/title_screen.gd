extends Control

func _ready() -> void:
	SceneManager.loading_scene.connect(hide)
	get_tree().get_first_node_in_group("Menu").quit_to_menu.connect(show)
