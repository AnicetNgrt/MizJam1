extends Modifier

class_name ModifierForwardModifier

var _to_propagate

func _ready():
	if get_child_count() > 0:
		_to_propagate = get_child(0)

# @param: game:Game
func execute(game):
	.execute(game)

# @param: game:Game
func undo(game):
	.undo(game)

func copy():
	var copy = get_script().new()
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return ""

func getFutureDescription():
	if silent: return ""
	return ""

func getPropagatedVersion():
	return _to_propagate
