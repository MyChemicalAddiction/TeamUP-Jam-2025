extends Node

"""
The SaveLoad singleton manages saving & loading data. This includes but is not
limited to the levels that have or haven't been completed yet (data which the
level selecting UI will use to)
"""

const SAVE_GAME_PATH := "user://savegame.tres"

## Emitted when the game is being saved.
signal saving

## Emitted when the game is being loaded.
signal loading

## The resource that holds all save data
@export var saveData: Resource = preload("res://scripts/save data custom resources/Instances/SaveDataResource.tres")

## Loads the save game data when launched
func _ready():
	load_game()

## Saves the current game data.
func save_game():
	ResourceSaver.save(saveData, SAVE_GAME_PATH)

## Loads game data if available.
func load_game():
	if ResourceLoader.exists(SAVE_GAME_PATH):
		saveData = load(SAVE_GAME_PATH)
