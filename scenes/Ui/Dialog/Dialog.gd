tool
extends Popup

export(String) var dname setget _set_dname
func _set_dname(val):
	dname = val
	if not is_inside_tree(): yield(self, "ready")
	$TitleContainer/Label.text = val

export(String) var text setget _set_text
func _set_text(val):
	text = val
	if not is_inside_tree(): yield(self, "ready")
	$TextContainer/MarginContainer/Label.text = val

export(String,"Némo") var character

signal okPressed(dialog)

func _on_LeatherButtonSmall_pressed():
	emit_signal("okPressed",self)

func initFrom(dialogContent):
	self.dname = dialogContent.title
	self.text = dialogContent.text
	self.character = dialogContent.character
