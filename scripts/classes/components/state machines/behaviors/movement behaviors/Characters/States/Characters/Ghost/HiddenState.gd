extends InputState
class_name GhostHiddenState

"""
Active when the ghost is hidden inside the amulet. In this state, it can't
do anything and is invisible.
"""

@export var IdleState: InputState
@export var GhostCollision: CollisionShape2D

@onready var amulet = get_tree().get_first_node_in_group("Amulet")

func process_input(_delta):
	input_manager.process_input()
	if input_manager.toggle_amulet:
		return IdleState
		
func process_physics(_delta: float):
	object.global_position = amulet.global_position ## The ghost should keep up with the amulet so the camera updates properly.

func _on_enter():
	object.visible = false
	object.velocity = Vector2.ZERO
	GhostCollision.disabled = true

func _on_exit():
	object.position = amulet.position
	GhostCollision.disabled = false
	object.visible = true
