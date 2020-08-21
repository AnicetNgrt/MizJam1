extends Modifier

class_name ModifierGotoTurn

var _nextTurn
var _previousTurn

func _init(turnNum:int, previousTurn:int = -1):
	_nextTurn = turnNum
	_previousTurn = previousTurn

func execute(game):
	.execute(game)
	_previousTurn = game.currentTurn
	game.gotoTurn(_nextTurn)

func undo(game):
	.undo(game)
	game.gotoTurn(_previousTurn)

func copy():
	return get_script().new(_nextTurn, _previousTurn)
