extends Game

class_name GameReactive

const _ActionSkipTurnPackedScene = preload("res://scenes/Action/Actions/ActionSkipTurn.tscn")
var _canSkipTurnTester = _ActionSkipTurnPackedScene.instance()

const _ActionPlacePawnPackedScene = preload("res://scenes/Action/Actions/ActionPlacePawn.tscn")
var _canPlacePawnTester = _ActionPlacePawnPackedScene.instance()

var mySide = 0
var myTurn = false
var _canSkipTurn = false
var hasPawnUnplaced = false setget _set_hasPawnUnplaced
func _set_hasPawnUnplaced(val):
	hasPawnUnplaced = val

func executeModifier(modifier):
	if modifier is ModifierSetPlayingSide:
		pass
	.executeModifier(modifier)
	get_parent()
	if modifier is ModifierSetPlayingSide:
		_onTurnSideChanged(modifier._sideNum)
	_checkHasUnplacedPawns()
	_checkCanSkipTurnChanged()

func _checkHasUnplacedPawns():
	var has = false
	for p in _getSideByNum(mySide).getUnplacedPawns():
		_onPawnUnplaced(p)
		has = true
	hasPawnUnplaced = has

func _checkCanSkipTurnChanged():
	var _new_canSkipTurn = _canSkipTurnTester.isValid(self, _getSideByNum(mySide))
	if _new_canSkipTurn and not _canSkipTurn:
		_onTurnCanBeSkipped()
	elif not _new_canSkipTurn and _canSkipTurn:
		_onTurnCantBeSkipped()
	_canSkipTurn = _new_canSkipTurn

func _onPawnUnplaced(pawn):
	pass

func _onTurnCanBeSkipped():
	pass

func _onTurnCantBeSkipped():
	pass

func _onTurnSideChanged(sideNum):
	if sideNum == mySide:
		_onMyTurn()
	else:
		_onNotMyTurn()

func _onMyTurn():
	myTurn = true

func _onNotMyTurn():
	myTurn = false

func _can_place_pawn_on_tile(tile):
	if hasPawnUnplaced:
		var index = _get_lastUnplacedPawnIndex()
		_canPlacePawnTester.pawnIndex = index
		_canPlacePawnTester.pos = tile.position
		return _canPlacePawnTester.isValid(self, _getSideByNum(mySide))
	return false

func _get_lastUnplacedPawnIndex():
	var side = _getSideByNum(mySide)
	var pawns = side.getPawns()
	var unplacedPawns = side.getUnplacedPawns()
	return pawns.find(unplacedPawns[0],0)
