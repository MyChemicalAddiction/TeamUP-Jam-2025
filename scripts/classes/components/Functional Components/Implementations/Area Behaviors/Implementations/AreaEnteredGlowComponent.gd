extends AreaEnteredComponent
class_name AreaEnteredGlowComponent

"""
The AreaEnteredGlowComponent provides visual feedback to players that wish to
interact with an InteractionArea by making that InteractionArea's sprite change
when the player is able to interact with it. It implements the
AreaEnteredComponent's interface.
"""

## Assign this the thing that you want to glow (usually a Sprite).
@export var visual: Node

## Keeps track of the current tween.
var current_tween : Tween

## Keeps track of the visual's alpha.
var visual_target_modulate: Color

## Keeps track of the visual's default alpha value.
var visual_default_modulate: Color

func _on_ready_behavior():
	visual_default_modulate = visual.modulate
	visual_target_modulate = Color(visual_default_modulate)
	visual_target_modulate[3] = 0.25
	
func _on_use():
	if current_tween:
		current_tween.kill()

	visual.modulate = visual_default_modulate
	
	current_tween = self.create_tween()
	current_tween.tween_property(visual, "modulate", visual_target_modulate, 0.5)
	current_tween.tween_callback(return_to_normal)
	
func return_to_normal():
	current_tween = self.create_tween()
	current_tween.tween_property(visual, "modulate", visual_default_modulate, 0.5)
