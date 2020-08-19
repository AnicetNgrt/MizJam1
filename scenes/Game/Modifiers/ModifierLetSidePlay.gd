extends Modifier

class_name ModifierLetSidePlay

var _sideNum
var _previousSideNum

func _init(sideNum:int):
	_sideNum = sideNum

func execute(game:Game):
	.execute(game)
	_previousSideNum = game.playingSideNum
	game.playingSideNum = _sideNum

func undo(game:Game):
	.undo(game)
	game.playingSideNum = _previousSideNum
