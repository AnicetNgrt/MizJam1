extends MarginContainer


func getGlobalAnchorPosForPawn(index:int):
	var anchor = null
	match(index-3):
		0: anchor = $MarginContainer/HBoxContainer/Slot1/Control
		1: anchor = $MarginContainer/HBoxContainer/Slot2/Control
		2: anchor = $MarginContainer/HBoxContainer/Slot3/Control
		3: anchor = $MarginContainer/HBoxContainer/Slot4/Control
	return anchor.rect_global_position
