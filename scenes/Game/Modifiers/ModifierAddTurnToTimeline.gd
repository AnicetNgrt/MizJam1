extends Modifier

class_name ModifierAddTurnToTimeline

# @type: Turn
var _turn

# @param: turn:Turn
func _init(turn):
	_turn = turn

# @param: game:Game
func execute(game):
	.execute(game)
	game.addTurnToTimeline(_turn)

# @param: game:Game
func undo(game):
	.undo(game)
	game.removeTurnFromTimeline(_turn)
