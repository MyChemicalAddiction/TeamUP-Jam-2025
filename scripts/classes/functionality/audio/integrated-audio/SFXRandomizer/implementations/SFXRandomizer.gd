extends Node
class_name SFXRandomizer

'''
Holds multiple audiostream resources from which it randomly selects one to make
a delegated AudioStreamPlayer play.
'''

@export var autoplay := false ## If this plays when the scene is loaded

@export var audio_player: AudioStreamPlayer
@export var audio_list: Array[AudioStream]

func _ready():
	if autoplay:
		play()

func play(param=null):
	audio_player.stream = audio_list.pick_random()
	audio_player.play()

func stop(param=null):
	audio_player.stop()
