extends Modifier

class_name ModifierAddDialogAndRead

func _init():
	pass

# @param: game:Game
func execute(game):
	.execute(game)
	if get_child_count() > 0 and game.has_method("addDialog") and game.has_method("readDialogFromName"):
		var content = get_child(0)
		remove_child(content)
		if game.has_method("addDialog"):
			var _name = game.addDialog(content)
			game.readDialogFromName(_name)

func copy():
	var copy = get_script().new()
	copy.propagate = propagate
	copy.silent = silent
	copy.add_child(get_child(0).copy())
	return copy

func getPastDescription():
	if silent: return ""
	return ""

func getFutureDescription():
	if silent: return ""
	return ""

func getPropagatedVersion():
	return copy()
