extends Resource
class_name SettingsData

"""
The SettingsData resource stores data that the players have
set in the game's settings and is saved/loaded by the SaveLoad
singleton.
"""

## 0 is the standard keyboard/mouse input. 1 (will be added later) is for users with low-end keyboards that suffer from ghosting - the mouse is used for all ghost actions, and keyboard - for human actions. 
@export var input_mode := 0 
