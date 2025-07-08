extends Area2D
class_name InteractionManager

"""
The interaction manager manages multiple interactables within the same area, 
prioritizing the closest interactable first.
"""

@export var interact_mask: int = 4
@export var player: Character ## References the character.
@export var input_manager: InputManager ## Manages varying inputs for interacting.
# @onready var label = $Label

# const base_text = "[E] to "

var active_areas: Array[Node] ## The list of interaction areas within the player's grasp.
var can_interact = true ## Whether the player can interact at this time.
var enabled: bool = false : ## Allows the InteractionManager to be disabled/enabled.
	get:
		return enabled 
	set(value):
		enabled = value
		set_process(enabled)

func _ready(): ## Sets the collision mask to detect the interaction area's collision layer (4)
	collision_mask = interact_mask
	enabled = false
	area_entered.connect(_on_area_entered) ## Dynamically connects own area_entered signal to self
	area_exited.connect(_on_area_exited) ## Dynamically connects own area_exited signal to self

func register_area(area: InteractionArea): ## Adds an area to active_areas
	if len(active_areas) == 0:
		enabled = true
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea): ## Removes an area from active_areas
	if len(active_areas) == 1:
		enabled = false
	active_areas.erase(area)

func _process(_delta): ## Processes input
	input_manager.process_input()
	if input_manager.pressed_interact && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			
			active_areas.sort_custom(_sort_by_distance_to_player)
			
			await active_areas[0].interact()
			
			can_interact = true

func _sort_by_distance_to_player(area1, area2): ## Prioritize closer areas in active_areas list.
	#if player == null: ## Commented out to avoid silent errors
	#	return false
	var area1_to_player = player.global_position.distance_squared_to(area1.global_position)
	var area2_to_player = player.global_position.distance_squared_to(area2.global_position)
	return area1_to_player < area2_to_player

func _on_area_entered(area: Area2D) -> void: ## Adds the InteractionArea to active_areas if it's in the InteractionManager's reach.
	if area is InteractionArea:
		register_area(area)

func _on_area_exited(area: Area2D) -> void: ## When an area leaves the interaction manager's reach, it should be erased from active_areas
	if area is InteractionArea:
		unregister_area(area)
