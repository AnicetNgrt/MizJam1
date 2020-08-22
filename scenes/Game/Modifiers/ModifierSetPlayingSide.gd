extends Modifier

class_name ModifierSetPlayingSide

export var _sideNum:int
var _previousSideNum
var _turn = null
var _part = null

func _init(sideNum:int = 0, previousSideNum:int = -1):
	_sideNum = sideNum
	_previousSideNum = previousSideNum

# @param: game:Game
func execute(game):
	.execute(game)

# @param: game:Game
func undo(game):
	.undo(game)

func copy():
	var copy = get_script().new(_sideNum, _previousSideNum)
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return ""

func getFutureDescription():
	if silent: return ""
	return ""
