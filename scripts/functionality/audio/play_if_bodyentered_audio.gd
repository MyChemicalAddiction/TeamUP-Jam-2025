extends FmodEventEmitter2D

"""
Plays when body_entered is emitted by object.
"""

@export var object : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	object.body_entered.connect(_play)

func _play(_body):
	if !get_tree().paused:
		play(true)
