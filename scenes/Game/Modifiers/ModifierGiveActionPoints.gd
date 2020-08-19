extends Modifier

class_name ModifierGiveActionPoints

var _sideNum: int
var _count: int

func _init(sideNum:int,count:int):
	_sideNum = sideNum
	_count = count

func execute(game:Game):
	.execute(game)
	game.addActionPointsToSide(_sideNum,_count)

func undo(game:Game):
	.undo(game)
	game.removeActionPointsFromSide(_sideNum,_count)
