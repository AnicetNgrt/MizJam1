extends Modifier

class_name ModifierGiveActionPoints

var _sideNum: int
var _count: int

func _init(sideNum:int,count:int):
	_sideNum = sideNum
	_count = count

# @param: game:Game
func execute(game):
	.execute(game)
	game.addActionPointsToSide(_sideNum,_count)

# @param: game:Game
func undo(game):
	.undo(game)
	game.removeActionPointsFromSide(_sideNum,_count)

func copy():
	var copy = get_script().new(_sideNum, _count)
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return "<s"+str(_sideNum)+"> was given "+str(_count)+" action points."

func getFutureDescription():
	if silent: return ""
	return "<s"+str(_sideNum)+"> will be given "+str(_count)+" action points."
