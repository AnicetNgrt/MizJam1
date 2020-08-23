extends Modifier

class_name ModifierPlacePawn

export(int) var _sideNum = 0
export(int) var _pawnIndex = 0
export(Vector2) var _pos

func _init(sideNum:int = 0, pawnIndex:int = 0, pos:Vector2 = Constants.UNPLACED_COORD):
	_sideNum = sideNum
	_pawnIndex = pawnIndex
	_pos = pos

# @param: game:Game
func execute(game):
	.execute(game)
	game.placePawnTo(_sideNum,_pawnIndex,_pos)

# @param: game:Game
func undo(game):
	.undo(game)

func copy():
	var copy = get_script().new(_sideNum, _pawnIndex, _pos)
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return "<s"+str(_sideNum)+">'s pawn was placed to ("+str(_pos.x)+", "+str(_pos.y)+")"

func getFutureDescription():
	if silent: return ""
	return "<s"+str(_sideNum)+">'s pawn will be placed to ("+str(_pos.x)+", "+str(_pos.y)+")"

func getPropagatedVersion():
	return copy()
