extends Control
class_name Menu

"""
The Menu node can instance the actual playable 2D game world if it receives 
the corresponding signal from a UI child.

It also manages "section switching" functionality. I.e., going from the main
menu screen to the settings screen and back, etc. In this sense, it's sort of
like a state machine except the actual states (in this case, the UI sections)
don't have a process function; they only communicate via signals back to the
Menu.
"""

## Emitted when made visible (during play)
signal toggled

## Emitted when made invisible (during play)
signal untoggled

## The resource of the main scene of the game
@export var main_game_scene_res := preload("res://scenes/main.tscn")

## The current visible UI section
@export var current_section: Control

var default_section: Control

## The node reference to the main game scene (once instanced)
var main_game_scene: Node

## Emitted when a level is selected
signal level_selected 

func _ready():
	default_section = current_section
	current_section.visible = true
	set_process(false) ## Makes it so Escape doesn't do anything when already in menu.

## Called to switch to another UI section (E.g. from any section to Settings. Settings section should be pased as the new_section)
func switch_section(new_section):
	current_section.visible = false ## Hides the current section
	
	new_section.visible = true ## Shows the new section
	current_section = new_section

## Loads a level as passed by a LevelButton's signal
func instantiate_game(level: PackedScene):
	level_selected.emit()
	
	current_section.visible = false ## Hides the current UI section
	set_process(true)
	
	if main_game_scene:
		main_game_scene.process_mode = Node.PROCESS_MODE_INHERIT
		SceneManager.transition_to_scene(level)
		return
	
	main_game_scene = main_game_scene_res.instantiate() 
	
	main_game_scene.default_scene = level ## Sets the main scene to load the level passed 
	
	add_child(main_game_scene) ## Adds the new scene

## Allows opening the menu during play
func _process(_delta) -> void:
	if main_game_scene:
		if Input.is_action_just_pressed("toggle_menu"):
			if !current_section.visible:
				toggled.emit()
				main_game_scene.process_mode = Node.PROCESS_MODE_DISABLED
				switch_section(default_section)
			else:
				untoggled.emit()
				current_section.visible = false
				main_game_scene.process_mode = Node.PROCESS_MODE_INHERIT
