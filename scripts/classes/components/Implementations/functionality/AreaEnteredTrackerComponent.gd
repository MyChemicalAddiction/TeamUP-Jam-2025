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

## Emitted when there's 0 areas inside the Tracking Area.
signal area_empty

## Emitted when one area is inside the Tracking Area.
signal area_present

## The list of areas within the specific area's grasp.
var active_areas: Array[Node]

@export var track_areas := true ## Whether this tracks areas entering the area.
@export var track_bodies := false ## Whether this tracks bodies entering the area.

@export var excluded: Array[Node] ## Things that shouldn't get registered.

func _ready():
	if track_areas:
		tracking_area.area_entered.connect(_on_area_entered)
		tracking_area.area_exited.connect(_on_area_exited) 
	if track_bodies:
		tracking_area.body_entered.connect(_on_area_entered)
		tracking_area.body_exited.connect(_on_area_exited) 

func _on_area_entered(area: Node) -> void: ## Adds the InteractionArea to active_areas if it's in the InteractionManager's reach.
	if !(area in excluded):
		_register_area(area)

func _on_area_exited(area: Node) -> void: ## When an area leaves the interaction manager's reach, it should be erased from active_areas
	if !(area in excluded):
		_unregister_area(area)

## Implementation-defined for condition checking before appending an area
func area_condition_check(_area) -> bool: 
	return true

func _register_area(area: Node): ## Adds an area/body to active_areas
	if area_condition_check(area):
		active_areas.push_back(area)
		area_entered.emit()
		if len(active_areas) == 1: 
			area_present.emit()
	
func _unregister_area(area: Node): ## Removes an area/body from active_areas
	if area_condition_check(area):
		active_areas.erase(area)
		area_exited.emit()
		if len(active_areas) == 0:
			area_empty.emit()
	
## Sorts the active_areas list by distance to the selected export object variable.
func sort_areas_by_distance():
	if object:
		active_areas.sort_custom(_sort_by_distance_to_object)

func _sort_by_distance_to_object(area1, area2): ## Prioritize closer areas in active_areas list.
	var area1_to_player = object.global_position.distance_squared_to(area1.global_position)
	var area2_to_player = object.global_position.distance_squared_to(area2.global_position)

	return area1_to_player < area2_to_player
