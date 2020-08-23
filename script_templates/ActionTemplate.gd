extends Action

class_name

func isValid(game, sender) -> bool:
	return false

func getModifiers(game, sender):
	var children = get_children()
	for c in children:
		remove_child(c)
	return children

func getNetworkObject():
	return {}
