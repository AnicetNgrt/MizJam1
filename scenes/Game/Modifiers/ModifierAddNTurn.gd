extends Modifier

class_name ModifierAddNTurn

const _TurnPackedScene = preload("res://scenes/Turn/Turn.tscn")

export var _n: int
export var _at: int
var _turns = []

func _init(at:int = 0, n: int = 0):
	_n = n
	_at = at

# @param: game:Game
func execute(game):
	.execute(game)
	for i in range(_at, _at+_n):
		_turns.append(_TurnPackedScene.instance())
		_turns[i].num = i
		game.addTurnToTimeline(_turns[i])

# @param: game:Game
func undo(game):
	.undo(game)
	for i in range(_at+_n-1, _at-1, -1):
		game.removeTurnFromTimeline(_turns[i])

func copy():
	return get_script().new(_at, _n)

func getPastDescription():
	return str(_n)+" turns from turn n°"+str(_at)+" were added to the game."

func getFutureDescription():
	return str(_n)+" turns from turn n°"+str(_at)+" will be added to the game."

func getPropagatedVersion():
	return copy()
