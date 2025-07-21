extends Marker2D
class_name PlayersStartMarker

"""
Marks where the players should start on any level.
"""

func _ready():
	add_to_group("PlayersStartMarker")
	var players = get_tree().get_nodes_in_group("Player")
	for i in players:
		i.global_position = global_position
	
	var camera = get_tree().get_first_node_in_group("camera")
	camera.global_position = global_position
