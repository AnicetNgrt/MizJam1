extends Modifier

class_name #put classname

func _init():
	pass

# @param: game:Game
func execute(game):
	.execute(game)
	pass

# @param: game:Game
func undo(game):
	.undo(game)
	pass

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

func getPropagatedVersion():
	return copy()
