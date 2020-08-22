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
	var copy = get_script().new(_sname, _actionPoints)
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return ""

func getFutureDescription():
	if silent: return ""
	return ""
