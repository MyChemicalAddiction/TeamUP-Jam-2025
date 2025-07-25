extends Button
class_name LevelButton

"""
When pressed, the level button starts the game at a specific level (as held
by the level var.)
"""

## The level that this button loads
@export var level: PackedScene 

## The top menu control node (to which it connects the section_switch signal)
@onready var menu = get_tree().get_first_node_in_group("Menu")

## Emitted when the button is released
signal level_select(level: PackedScene)

## Connects own level_select signal to be emitted when the button is released
func _ready():
	button_up.connect(select_level)
	level_select.connect(menu.instantiate_game)

## Emits the level_select signal with the relevant level
func select_level():
	level_select.emit(level)
