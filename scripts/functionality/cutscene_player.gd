extends Control

"""
The Cutscene Player is what the CutscenePlayer singleton delegates cutscene 
playing functionality to.
"""

var cutscenes : Dictionary[String, bool]

func _ready():
	SaveLoad.loaded.connect(update)
	CutscenePlayer.cutscene_player = self
	process_mode = Node.PROCESS_MODE_ALWAYS

func update():
	var level_completed_data = SaveLoad.get_data("level_completed_data")

	for i in range(len(cutscenes.values())):
		cutscenes[cutscenes.values()[i]] = false

	for i in range(len(level_completed_data)):
		cutscenes[cutscenes.values()[i]] = true

func play_cutscene():
	var index = len(SaveLoad.get_data("level_completed_data")) - 1

	if !cutscenes[cutscenes.values()[index]]:
		var new_cutscene = load(cutscenes.values()[index])
		cutscenes[cutscenes.values()[index]] = true
		
		add_child(new_cutscene)
		
		await new_cutscene.finished
		CutscenePlayer.finished.emit()
