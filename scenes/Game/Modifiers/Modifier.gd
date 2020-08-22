extends Node

class_name Modifier

var previousModifier:Modifier = null

# @param: game:Game
func execute(game):
	pass

# @param: game:Game
func undo(game):
	pass

func copy():
	return get_script().new()

func getPastDescription():
	return "Something happened, but there is no known detail about it."

func getFutureDescription():
	return "Something will happen, but there is no known detail about it."

func shallBePropagated() -> bool:
	return true

func getPropagatedVersion():
	return copy()
