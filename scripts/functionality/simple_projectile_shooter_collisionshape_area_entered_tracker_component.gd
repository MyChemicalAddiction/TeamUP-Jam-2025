extends AreaEnteredTrackerComponent

## Implementation-defined for condition checking before appending an area
func area_condition_check(_area) -> bool: 
	return not(_area is TileMapLayer)
