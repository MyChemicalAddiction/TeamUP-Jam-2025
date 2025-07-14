extends Component
class_name AreaEnteredTrackerComponent

"""
The AreaEnteredTrackerComponent encapsulates logic for keeping track of which
areas are currently within the radius of a specific area.
"""

## The area which keeps track of entered areas
@export var tracking_area: Area2D

## If set to something, this tracker will be able to sort the active areas by list how close they are to this object.
@export var object: Node2D

## Emitted when an area enters/exits
signal area_entered 
signal area_exited

## The list of areas within the specific area's grasp.
var active_areas: Array[Node]

func _ready():
	tracking_area.area_entered.connect(_on_area_entered) ## Dynamically connects own area_entered signal to self
	tracking_area.area_exited.connect(_on_area_exited) ## Dynamically connects own area_exited signal to self

func _on_area_entered(area: Area2D) -> void: ## Adds the InteractionArea to active_areas if it's in the InteractionManager's reach.
	_register_area(area)

func _on_area_exited(area: Area2D) -> void: ## When an area leaves the interaction manager's reach, it should be erased from active_areas
	_unregister_area(area)

## Implementation-defined for condition checking before appending an area
func area_condition_check(_area) -> bool: 
	return true

func _register_area(area: Area2D): ## Adds an area to active_areas
	if area_condition_check(area):
		active_areas.push_back(area)
		area_entered.emit()
	
func _unregister_area(area: Area2D): ## Removes an area from active_areas
	active_areas.erase(area)
	area_exited.emit()

## Sorts the active_areas list by distance to the selected export object variable.
func sort_areas_by_distance():
	active_areas.sort_custom(_sort_by_distance_to_object)

func _sort_by_distance_to_object(area1, area2): ## Prioritize closer areas in active_areas list.
	var area1_to_player = object.global_position.distance_squared_to(area1.global_position)
	var area2_to_player = object.global_position.distance_squared_to(area2.global_position)
	
	return area1_to_player < area2_to_player
