extends StateListener
class_name FmodPlayingStateListener

@export var fmod_event_emitter: FmodEventEmitter2D

@export var on_enter := true
@export var on_exit := false

## if true, then stops when the state is in the opposite state than that which triggers the playing of the audio. E.G: if on_enter is true, then when the state is exited - this stops playing.
@export var stop_if_opposite := true

## if true, keeps playing the event.
@export var continuous := false

func _ready() -> void:
	super()
	set_process(false)

func _on_state_entered(): ## Overridden to provide behavior on the state being entered.
	if on_enter:
		if _check_condition():
			if continuous:
				set_process(true)
				return
			fmod_event_emitter.play()
	else:
		if continuous and stop_if_opposite:
			set_process(false)

func _on_state_exited():
	if on_exit:
		if _check_condition():
			if not get_tree().paused:
				if continuous:
					set_process(true)
					return
				fmod_event_emitter.play()
	else:
		if continuous and stop_if_opposite:
			set_process(false)

func _process(_delta):
	fmod_event_emitter.play(false)

func _check_condition() -> bool: ## Overridden by implementations to check for a condition before playing.
	return true
