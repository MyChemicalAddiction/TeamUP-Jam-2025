extends Node
class_name SFXRandomizer

'''
Holds multiple audiostream resources from which it randomly selects one to make
a delegated AudioStreamPlayer play.
'''

@export var autoplay := false ## If this plays when the scene is loaded

@export var audio_player: AudioStreamPlayer ## Left null if it should use the global sfx player.
@export var audio_list: Array[AudioStream]

func _ready():
	if autoplay:
		play()

func play(param=null):
	if audio_player:
		audio_player.stream = audio_list.pick_random()
		audio_player.play()
	else:
		audio_player = GlobalSFX.play_sound(audio_list.pick_random())

func stop(param=null):
	if audio_player:
		audio_player.stop()
