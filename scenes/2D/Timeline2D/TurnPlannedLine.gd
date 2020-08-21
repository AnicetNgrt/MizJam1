tool
extends MarginContainer

export(String) var text = "" setget _set_text
func _set_text(val):
	text = val
	if not is_inside_tree(): yield(self, "ready")
	$Elements/Label.text = text
