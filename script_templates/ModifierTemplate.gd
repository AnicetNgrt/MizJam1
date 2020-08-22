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
	pass

func getPastDescription():
	return "Something happened, but there is no known detail about it."

func getFutureDescription():
	return "Something will happen, but there is no known detail about it."

func getPropagatedVersion():
	return copy()
