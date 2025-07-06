extends InputState
class_name GhostHiddenState

@export var IdleState: InputState
@export var GhostCollision: CollisionShape2D
@export var amulet: Node

func process_input(_delta):
	input_manager.process_input()
	if input_manager.toggle_amulet:
		return IdleState
		
func process_physics(_delta: float):
	pass

func _on_enter():
	object.visible = false
	object.velocity = Vector2.ZERO
	GhostCollision.disabled = true

func _on_exit():
	object.position = amulet.position
	GhostCollision.disabled = false
	object.visible = true
