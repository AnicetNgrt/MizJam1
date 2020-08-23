extends Action

class_name ActionSkipTurn

func isValid(game, sender) -> bool:
	var current = game._timeline.getCurrentlyPlayingSideNumOrNull()
	return sender.get_index()+1 == current and current != null

func getModifiers(game, sender):
	var children = get_children()
	for c in children:
		remove_child(c)
	return children

func getNetworkObject():
	return {name:"ActionSkipTurn"}
