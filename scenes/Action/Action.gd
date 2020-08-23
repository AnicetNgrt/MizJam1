extends Node

class_name Action

func setModifiers(modifiers):
	for c in get_children():
		remove_child(c)
		c.queue_free()
	for m in modifiers:
		add_child(m)

func isValid(game, sender) -> bool:
	return false

func getModifiers(game, sender):
	var children = get_children()
	for c in children:
		remove_child(c)
	return children

func getNetworkObject():
	return {}
