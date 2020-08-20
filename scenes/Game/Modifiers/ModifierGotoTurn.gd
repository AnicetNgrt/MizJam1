extends Modifier

class_name ModifierGotoTurn

var _nextTurn
var _previousTurn

func _init(turnNum:int):
	_nextTurn = turnNum

func execute(game:Game):
	.execute(game)
	_previousTurn = game.currentTurn
	game.gotoTurn(_nextTurn)

func undo(game:Game):
	.undo(game)
	game.gotoTurn(_previousTurn)
