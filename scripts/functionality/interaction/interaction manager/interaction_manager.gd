extends Node2D

"""
The interaction manager manages multiple interactables within the same area, prioritizing
the closest interactable first.
"""

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = "[E] to "

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)
	active_areas.sort_custom(_sort_by_distance_to_player)
	
func unregister_area(area: InteractionArea):
	active_areas.erase(area)
	active_areas.sort_custom(_sort_by_distance_to_player)
		
func _process(_delta):
	if active_areas.size() > 0 && can_interact:
		if player == null:
			player = get_tree().get_first_node_in_group("player")
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()
		
func _sort_by_distance_to_player(area1, area2):
	if player == null:
		return false
		
	var area1_to_player = player.global_position.distance_squared_to(area1.global_position)
	var area2_to_player = player.global_position.distance_squared_to(area2.global_position)
	return area1_to_player < area2_to_player
	
func _input(event):
	if event.is_action_pressed("human_interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			if active_areas[0].has_method("interact"):
				await active_areas[0].interact()
			
			can_interact = true
