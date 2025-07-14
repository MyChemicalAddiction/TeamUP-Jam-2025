extends AreaEnteredTrackerComponent

func area_condition_check(area) -> bool:
	if area is Hurtbox:
		return true
	return false
