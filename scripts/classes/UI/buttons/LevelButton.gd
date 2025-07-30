extends Button
class_name LevelButton

"""
When pressed, the level button starts the game at a specific level (as held
by the level var.)
"""

## The path to the level that this button loads
@export var level_path: String

## The level that this button loads
@onready var level = load(level_path) if level_path else null

## The top menu control node (to which it connects the section_switch signal)
@onready var menu = get_tree().get_first_node_in_group("Menu")

## The text of this button by default (without "Completed")
@onready var original_text = text

## Emitted when the button is released
signal level_select(level: PackedScene)

## Connects own level_select signal to be emitted when the button is released
func _ready():
	update()
	
	button_up.connect(select_level)
	level_select.connect(menu.instantiate_game)
	
	SaveLoad.saved.connect(update)
	SaveLoad.loaded.connect(update)

func update():
	if level_path in SaveLoad.get_data("level_completed_data") and level_path:
		if !("(Completed)" in text): text += " (Completed)"
	else:
		text = original_text

## Emits the level_select signal with the relevant level
func select_level():
	var index = len(SaveLoad.get_data("level_completed_data")) - 1
	if index == -1: ## If this is the first level ever played:
		if !SaveLoad.get_data("played_intro_cutscene"):
			var cutscene_player = get_tree().get_first_node_in_group("cutscene_player")
			if !cutscene_player.finished_intro_cutscene.is_connected(start_first_level):
				cutscene_player.finished_intro_cutscene.connect(start_first_level)
			cutscene_player.play_intro_cutscene()
			return

	level_select.emit(level)

func start_first_level():
	level_select.emit(level)
