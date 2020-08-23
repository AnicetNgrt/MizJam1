extends Node

class_name Modifier

var previousModifier:Modifier = null

export var propagate: bool
export var silent: bool
var executed = false

# @param: game:Game
func execute(game):
	executed = true

# @param: game:Game
func undo(game):
	executed = false

func copy():
	var copy = get_script().new()
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return "Something happened, but there is no known detail about it."

func getFutureDescription():
	if silent: return ""
	return "Something will happen, but there is no known detail about it."

func shallBePropagated() -> bool:
	return true

func getPropagatedVersion():
	return copy()
