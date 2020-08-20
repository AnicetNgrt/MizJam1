extends Modifier

class_name ModifierAddTurnToTimeline

var _turn:Turn

func _init(turn:Turn):
	_turn = turn

func execute(game:Game):
	.execute(game)
	game.addTurnToTimeline(_turn)

func undo(game:Game):
	.undo(game)
	game.removeTurnFromTimeline(_turn)
