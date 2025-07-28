extends FmodEventEmitter2D

"""
Encapsulates logic for playing a death sound effect when a hurtbox emits a
destroyed signal.
"""

@export var hurtbox: Hurtbox

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hurtbox.destroyed.connect(play)
