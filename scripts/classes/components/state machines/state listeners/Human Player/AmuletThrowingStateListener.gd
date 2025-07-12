extends StateListener

@onready var object = get_parent() ## Needed to reference the arrow sprite

## TODO: remove this later, this is hardcoded visual feedback for debugging purposes only 
var modulate_alpha := 1.0
## TODO: remove the above later

func _on_state_entered(): ## Shows where the arrow is pointing.
	object.rotation = (global_position - state.mouse_pos).angle() ## Points the arrow correctly before revealing it.
	
	## TODO: remove this later, this is hardcoded visual feedback for debugging purposes only
	object.modulate[3] = 0.0
	## TODO: remove the above later
	
	object.visible = true
	set_physics_process(true) 

func _on_state_exited(): ## Makes the arrow invisible.
	object.visible = false
	set_physics_process(false) 

func _physics_process(_delta: float) -> void:
	object.rotation = (global_position - state.mouse_pos).angle()
	
	## TODO: remove this later, this is hardcoded visual feedback for debugging purposes only 
	modulate_alpha = state.force_multiplier
	object.modulate[3] = modulate_alpha
	## TODO: remove the above later
