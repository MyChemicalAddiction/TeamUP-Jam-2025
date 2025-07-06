extends StateListener

@export var object: Node ## Needed to reference the arrow sprite


func _on_state_entered(): ## Shows where the arrow is pointing.
	object.rotation = (global_position - state.mouse_pos).angle() ## Points the arrow correctly before revealing it.
	object.visible = true

func _on_state_exited(): ## Makes the arrow invisible.
	object.visible = false

func _physics_process(_delta: float) -> void:
	object.rotation = (global_position - state.mouse_pos).angle()
