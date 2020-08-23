extends Modifier

class_name ModifierConsumeCard

export(int) var _cardIndex = 0
export(int) var _sideNum = 0

func _init(cardIndex:int = 0, sideNum:int = 0):
	_cardIndex = cardIndex
	_sideNum = sideNum

# @param: game:Game
func execute(game):
	.execute(game)
	game.consumeCard(_sideNum, _cardIndex)

# @param: game:Game
func undo(game):
	.undo(game)
	pass

func copy():
	var copy = get_script().new(_cardIndex, _sideNum)
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return ""

func getFutureDescription():
	if silent: return ""
	return ""

func getPropagatedVersion():
	return copy()
