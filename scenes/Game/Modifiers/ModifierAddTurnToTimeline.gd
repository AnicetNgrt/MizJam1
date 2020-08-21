extends Modifier

class_name ModifierAddTurnToTimeline

const _TurnPackedScene = preload("res://scenes/Turn/Turn.tscn")

# @type: Turn
var _turn
var _num
var _rules

# @param: turn:Turn
func _init(num:int, rules):
	_num = num
	_rules = rules
	_turn = _TurnPackedScene.instance()
	_turn.setup(num, rules)

# @param: game:Game
func execute(game):
	.execute(game)
	game.addTurnToTimeline(_turn)

# @param: game:Game
func undo(game):
	.undo(game)
	game.removeTurnFromTimeline(_turn)

func copy():
	return get_script().new(_num, _rules)
