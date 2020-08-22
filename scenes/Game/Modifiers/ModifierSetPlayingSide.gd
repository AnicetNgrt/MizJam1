extends Modifier

class_name ModifierSetPlayingSide

var _sideNum
var _previousSideNum

func _init(sideNum:int, previousSideNum:int = -1):
	_sideNum = sideNum
	_previousSideNum = previousSideNum

# @param: game:Game
func execute(game):
	.execute(game)
	_previousSideNum = game.playingSideNum
	game.playingSideNum = _sideNum

# @param: game:Game
func undo(game):
	.undo(game)
	game.playingSideNum = _previousSideNum

func copy():
	return get_script().new(_sideNum, _previousSideNum)

func getPastDescription():
	return ""

func getFutureDescription():
	return ""
