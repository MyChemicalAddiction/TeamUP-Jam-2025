extends Resource
class_name SaveData

"""
The SaveData resource holds all other resources relevant to saving game data.
"""

## The resource that holds settings that have been set by the players.
@export var settings: Resource = preload("res://scripts/save data custom resources/Instances/SettingsDataResource.tres")

## The resource that holds info on which levels have been completed (true) or not (false) yet.
@export var levelData: Resource = preload("res://scripts/save data custom resources/Instances/LevelDataResource.tres")
