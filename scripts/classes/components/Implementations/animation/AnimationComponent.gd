extends Component
class_name AnimationComponent

"""
The AreaAnimationComponent can play an animation when enabled, and stop that
animation & optionally play another one when disabled.
"""

@export var animation_player: AnimationPlayer

@export var on_enabled_animation: String
@export var on_disabled_animation: String

func _on_disable(): ## Hook for extra behavior on disabling.
	if on_disabled_animation:
		animation_player.play(on_disabled_animation)
	
func _on_enable(): ## Hook for extra behavior on enabling.
	if on_enabled_animation:
		animation_player.play(on_enabled_animation)
