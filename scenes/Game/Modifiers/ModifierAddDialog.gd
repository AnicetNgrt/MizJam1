extends Modifier

class_name ModifierAddDialog

func _init():
	pass

# @param: game:Game
func execute(game):
	.execute(game)
	if get_child_count() > 0 and game.has_method("addDialog"):
		var content = get_child(0)
		remove_child(content)
		game.addDialog(content)

func getPastDescription():
	if silent: return ""
	return ""

func getFutureDescription():
	if silent: return ""
	return ""

func getPropagatedVersion():
	return copy()
