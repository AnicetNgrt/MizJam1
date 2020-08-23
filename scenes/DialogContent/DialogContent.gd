extends Node

class_name DialogContent

export var title: String
export(String,MULTILINE) var text
export(String, "Némo") var character

func copy():
	var copy = get_script().new()
	copy.text = text
	copy.character = character
	copy.title = title
	for c in get_children():
		copy.add_child(c.copy())
	return copy
