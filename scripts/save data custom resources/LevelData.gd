extends Resource
class_name LevelData

"""
The LevelData resource stores data about which levels have or haven't yet been
completed, which the level selection UI can use to allow or disallow players
from playing certain levels (i.e. - those preceeded by levels that they haven't 
completed yet).
"""

## This dictionary maps the level paths to a boolean variable that describes whether they've been completed yet.
@export var level_completed_data: Dictionary[String, bool] 
