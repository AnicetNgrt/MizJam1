extends Modifier

class_name ModifierAddPawn

var _sideNum:int
var _pawn:Pawn

func _init(sideNum:int,pawn:Pawn):
	_sideNum = sideNum
	_pawn = pawn

func execute(game:Game):
	.execute(game)
	if game.canAddPawnToSide(_sideNum):
		game.addPawnToSide(_sideNum,_pawn)

func undo(game:Game):
	.undo(game)
	game.removePawnFromSide(_sideNum,_pawn)
