extends Action

class_name ActionSkipTurn

func isValid(game, sender) -> bool:
	var current = game._timeline.getCurrentlyPlayingSideNumOrNull()
	var hasToBeHisTurn = sender.get_index()+1 == current and current != null
	var hasToNotHaveUnplacedPawn = sender.getUnplacedPawns().size() == 0
	return hasToBeHisTurn and hasToNotHaveUnplacedPawn

func getModifiers(game, sender):
	var children = get_children()
	for c in children:
		remove_child(c)
	return children

func getNetworkObject():
	return {name:"SkipTurn"}
