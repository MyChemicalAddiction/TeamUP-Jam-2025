extends GPUParticles2D

@onready var ghost = get_tree().get_first_node_in_group("Ghost")

func _ready():
	ghost.visibility_changed.connect(toggle)

func toggle():
	emitting = !emitting

func _process(_delta: float) -> void:
	look_at(ghost.global_position)
