extends Node

"""
The SaveLoad singleton manages saving & loading data. This includes but is not
limited to the levels that have or haven't been completed yet (data which the
level selecting UI will use to)
"""

const SAVE_GAME_PATH := "user://savegame.tres"

## Emitted when the game saved some new data.
signal saved

## Emitted when the game loaded some new data.
signal loaded

## The resource that holds all save data
@export var saveDataRes: Resource = preload("res://scripts/save data custom resources/Instances/SaveDataResource.tres")

## The path to the resource that holds all save data
@export var saveDataResPath: String = "res://scripts/save data custom resources/Instances/SaveDataResource.tres"

## Loads the save game data when launched
func _ready():
	load_game()

## Saves the current game data.
func save_game():
	ResourceSaver.save(saveDataRes, SAVE_GAME_PATH)
	saved.emit()
	
## Loads game data if available.
func load_game():
	if ResourceLoader.exists(SAVE_GAME_PATH):
		saveDataRes = load(SAVE_GAME_PATH)
	
	loaded.emit()

## Changes the key attribute of dict dictionary with value value in saveDataRes
func change_data(property: String, value: Variant, duplicate_if_present=false):
	var ref = saveDataRes.get(property)
	if ref is Array:
		if value in ref:
			if !duplicate_if_present:
				return
		ref.push_back(value)
	save_game()

func reset_data():
	saveDataRes = load(saveDataResPath)
	save_game()
	loaded.emit()

## Returns a dict from the save data resource
func get_data(ref: String):
	return saveDataRes.get(ref)
