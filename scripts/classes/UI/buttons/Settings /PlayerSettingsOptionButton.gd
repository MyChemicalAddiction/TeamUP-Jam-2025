extends OptionButton
class_name PlayerSettingsOptionButton

"""
This class changes a setting in the player_settings_data dict of the 
SettingsData resource via dropdown options.
"""

## The name of the dictionary contained within SaveData that this will access
@export var saveDataDict: String = ""

## The key inside the player_settings_data dict of settingsData that will be changed upon selecting an option
@export var key: String = "input_mode"

func _ready():
	item_selected.connect(change_setting)

func change_setting(new_setting):
	var value = get_item_id(new_setting) ## IMPORTANT: the new value is equal to the ID of the item of this OptionButton that has been selected
	SaveLoad.change_data(saveDataDict, key, value)
