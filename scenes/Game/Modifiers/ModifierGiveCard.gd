extends Modifier

class_name ModifierGiveCard

export(int) var _sideNum

var _card = null

func _init(sideNum:int = 1):
	_sideNum = sideNum

# @param: game:Game
func execute(game):
	.execute(game)
	_card = get_child(0)
	remove_child(_card)
	game.giveCard(_card,_sideNum)

# @param: game:Game
func undo(game):
	.undo(game)
	pass

func copy():
	var copy = get_script().new(_sideNum)
	if _card == null:
		_card = get_child(0)
	copy.add_child(_card.duplicate())
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return "A card was given to <s"+str(_sideNum)+">"

func getFutureDescription():
	if silent: return ""
	return "A card will be given to <s"+str(_sideNum)+">"

func getPropagatedVersion():
	return copy()
