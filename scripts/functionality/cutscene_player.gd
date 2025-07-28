extends Control

"""
The Cutscene Player is what the CutscenePlayer singleton delegates cutscene 
playing functionality to.
"""

@export var cutscenes : Dictionary[String, bool]

func _ready():
	update()
	SaveLoad.loaded.connect(update) ## Updates which cutscnees have alraedy been played only on load
	CutscenePlayer.cutscene_player = self
	process_mode = Node.PROCESS_MODE_ALWAYS

## Updates which cutscenes have already beenn played
func update():
	var level_completed_data = SaveLoad.get_data("level_completed_data")

	for i in range(len(cutscenes.keys())):
		cutscenes[cutscenes.keys()[i]] = false

	for i in range(clamp(len(level_completed_data), 0, len(cutscenes.keys()) - 1)):
		cutscenes[cutscenes.keys()[i]] = true

## Instantiates a cutscene scene, awaits its finish signal then fades screen to black & at end of fade
func play_cutscene():
	get_tree().paused = true
	visible = true
	var index = len(SaveLoad.get_data("level_completed_data")) - 1

	if !cutscenes[cutscenes.keys()[index]]:
		if len(cutscenes.keys()[index]) > 2: ## Only instantiates a cutscene if the key at the index is longer than 2 characters (if not - means there is no cutscene after that amount of levels completed)
			var new_cutscene = load(cutscenes.keys()[index]).instantiate()
			cutscenes[cutscenes.keys()[index]] = true
			
			add_child(new_cutscene)
			
			await new_cutscene.finished
			
			CutscenePlayer.finished.emit()
			visible = false
		else:
			CutscenePlayer.finished.emit()
			visible = false
			cutscenes[cutscenes.keys()[index]] = true
