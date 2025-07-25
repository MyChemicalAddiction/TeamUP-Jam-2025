extends Resource
class_name SaveData

"""
The SaveData resource holds all other resources relevant to saving game data.
"""

## This dictionary maps the level paths to a boolean variable that describes whether they've been completed yet.
@export var level_completed_data: Dictionary[String, bool] = {
	
} 

## 0 is the standard keyboard/mouse input. 1 (will be added later) is for users with low-end keyboards that suffer from ghosting - the mouse is used for all ghost actions, and keyboard - for human actions. 
@export var player_settings_data: Dictionary[String, Variant] = {
	
}
