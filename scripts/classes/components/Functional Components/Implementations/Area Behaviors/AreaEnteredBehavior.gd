extends FunctionalComponent
class_name AreaEnteredComponent

"""
The AreaEnteredBehavior class employs the strategy pattern by encapsulating
behavior that should be triggered when an area is entered by another area.
"""

## The area that, when entered, triggers this behavior.
@export var area: Area2D

## Connects own use function to the area's entered signal.
func _on_ready():
	area.area_entered.connect(_on_area_entered)
	_on_ready_behavior()

## Overridden for extra behavor on ready
func _on_ready_behavior():
	pass

func _on_area_entered(_obj):
	use()
