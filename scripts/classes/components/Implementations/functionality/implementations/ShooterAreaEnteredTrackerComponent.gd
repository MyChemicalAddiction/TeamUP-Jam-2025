extends AreaEnteredTrackerComponent

func area_condition_check(area) -> bool:
	return (area is Hurtbox)
