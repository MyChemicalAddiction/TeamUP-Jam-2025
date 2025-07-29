extends StateListener

@export var fmod_event_emitter: FmodEventEmitter2D

@export var on_enter := true
@export var on_exit := false

## if true, keeps playing the event.
@export var continuous := false

func _ready() -> void:
	super()
	set_process(false)

func _on_state_entered(): ## Overridden to provide behavior on the state being entered.
	if on_enter:
		if continuous:
			set_process(true)
			return
		fmod_event_emitter.play()
	else:
		if continuous:
			set_process(false)

func _on_state_exited():
	if on_exit:
		if not get_tree().paused:
			if continuous:
				set_process(true)
				return
			fmod_event_emitter.play()
	else:
		if continuous:
			set_process(false)

func _process(_delta):
	fmod_event_emitter.play(false)
