extends AnimatedSprite2D

@onready var length = sprite_frames.get_frame_count(sprite_frames.get_animation_names()[0]) - 1

signal finished 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("cutscene_move"):
		if frame == length:
			finished.emit()
			return
		frame += 1
