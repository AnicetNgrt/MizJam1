extends Modifier

class_name ModifierAddPawn

export var _sideNum:int
export var _isAlive:bool
export var _pos:Vector2
var _addedPawn:Pawn = null

func _init(sideNum:int = 0,isAlive:bool = true,pos:Vector2 = Constants.UNPLACED_COORD):
	_sideNum = sideNum
	_isAlive = isAlive
	_pos = pos

func execute(game:Game):
	.execute(game)
	if game.canAddPawnToSide(_sideNum):
		var pawn = Pawn.new()
		pawn.isAlive = _isAlive
		pawn.pos = _pos
		game.addPawnToSide(_sideNum,pawn)

func undo(game:Game):
	.undo(game)
	if _addedPawn:
		game.removePawnFromSide(_sideNum,_addedPawn)
		_addedPawn = null

func copy():
	var copy = get_script().new(_sideNum,_isAlive,_pos)
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	var m = "<sname> has received a "
	if not _isAlive:
		m += "dead "
	m += "pawn"
	if _pos != Constants.UNPLACED_COORD:
		m += " located in ("+str(_pos.x)+", "+str(_pos.y)+")"
	m += "."
	return m

func getFutureDescription():
	if silent: return ""
	var m = "<sname> did receive a "
	if not _isAlive:
		m += "dead "
	m += "pawn"
	if _pos != Constants.UNPLACED_COORD:
		m += " located in ("+str(_pos.x)+", "+str(_pos.y)+")"
	m += "."
	return m
