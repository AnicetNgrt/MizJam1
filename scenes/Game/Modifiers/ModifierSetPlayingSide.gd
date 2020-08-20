extends Modifier

class_name ModifierSetPlayingSide

var _sideNum
var _previousSideNum

func _init(sideNum:int):
	_sideNum = sideNum

# @param: game:Game
func execute(game):
	.execute(game)
	_previousSideNum = game.playingSideNum
	game.playingSideNum = _sideNum

# @param: game:Game
func undo(game):
	.undo(game)
	game.playingSideNum = _previousSideNum
