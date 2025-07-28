extends Resource
class_name SaveData

"""
The SaveData resource holds all other resources relevant to saving game data.
"""

## Stores the completed levels' paths
@export var level_completed_data: Array[String] = [
	
]

## Whether the intro cutscene has been played yet
@export var played_intro_cutscene := false

## 0 is the standard keyboard/mouse input. 1 (will be added later) is for users with low-end keyboards that suffer from ghosting - the mouse is used for all ghost actions, and keyboard - for human actions. 
@export var player_settings_data: Dictionary[String, Variant] = {
	
}
