extends Node
class_name AudioPlayingComponent

"""
Used for communicating to the Component interface to decide when to play an
audio via a delegated AudioStreamPlayer node.
"""

@export var audio_player: Node
@export var component: Node

@export var on_enable := false
@export var on_disable := false
@export var on_use := false

@export var stop_on_enable := false
@export var stop_on_disable := false
@export var stop_on_use := false

func _ready():
	if on_enable:
		component.on_enabled.connect(play)
	if on_disable:
		component.on_disabled.connect(play)
	if on_use:
		component.used.connect(play)
		
	if stop_on_enable:
		component.on_enabled.connect(stop)
	if stop_on_disable:
		component.on_disabled.connect(stop)
	if stop_on_use:
		component.used.connect(stop)

func play():
	audio_player.play()

func stop():
	audio_player.stop()
