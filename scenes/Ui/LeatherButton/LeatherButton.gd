tool
extends CenterContainer

export(String) var label setget _set_label
func _set_label(val):
	if not is_inside_tree(): yield(self,"ready")
	label = val
	$Label.text = val

export(bool) var disabled = false setget _set_disabled
func _set_disabled(val):
	if not is_inside_tree(): yield(self,"ready")
	disabled = val
	$Button.disabled = val
	if disabled:
		$Label.set("custom_colors/font_color", Color.gray)
	else:
		$Label.set("custom_colors/font_color", Color.white)
