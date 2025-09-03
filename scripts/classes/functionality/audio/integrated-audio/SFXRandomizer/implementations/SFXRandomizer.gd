extends Node
class_name SFXRandomizer

'''
Holds multiple audiostream resources from which it randomly selects one to make
a delegated AudioStreamPlayer play.
'''

@export var audio_player: AudioStreamPlayer
@export var audio_list: Array[AudioStream]

func play(param=null):
	audio_player.stream = audio_list.pick_random()
	audio_player.play()
