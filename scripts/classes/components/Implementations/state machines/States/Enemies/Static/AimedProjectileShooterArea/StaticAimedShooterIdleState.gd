extends State
class_name StaticAimedShooterIdleState

"""
This state encapsulates behavior for when the lengthily (but appropriately)
named StaticAimedShooter enemy (otherwise known as AimedProjectileShooterArea)
is not shooting anything.
"""

## Hook for extra behavior when entered.
func _on_enter(): 
	pass

## Hook for extra behavior when exited.
func _on_exit(): 
	pass

## What this state should do every frame if it's active.
func process_physics(_delta):
	return null
