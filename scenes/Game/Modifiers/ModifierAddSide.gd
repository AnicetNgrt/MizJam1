extends Modifier

class_name ModifierAddSide

const _SidePackedScene = preload("res://scenes/Side/Side.tscn")

export var _sname:String
export var _actionPoints:int

func _init(sname:String = "Anonymous side", actionPoints:int = 0):
	_sname = sname
	_actionPoints = actionPoints

# @param: game:Game
func execute(game):
	.execute(game)
	var side = _SidePackedScene.instance()
	side.sname = _sname
	side.actionPoints = _actionPoints
	game.addSide(side)
	return side

func copy():
	return get_script().new(_sname, _actionPoints)

func getPastDescription():
	return ""

func getFutureDescription():
	return ""

func shallBePropagated() -> bool:
	return true
