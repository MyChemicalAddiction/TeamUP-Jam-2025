extends Node

"""
The CutscenePlayer singleton is referenced for playing cutscenes.
"""

signal finished

var cutscene_player: Node

func play_cutscene():
	cutscene_player.play_cutscene()
