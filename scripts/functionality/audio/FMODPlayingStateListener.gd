extends StateListener

@export var fmod_event_emitter: FmodEventEmitter2D

@export var on_enter := true
@export var on_exit := false

func _on_state_entered(): ## Overridden to provide behavior on the state being entered.
	if on_enter:
		fmod_event_emitter.play()

func _on_state_exited():
	if on_exit:
		if not get_tree().paused:
			fmod_event_emitter.play()
