extends ModifierAddSide

class_name ModifierAddSideWith2DController

const _Controller2DPackedScene = preload("res://scenes/Controller/ControllerPlayer/ControllerReactive/Controller2D/Controller2D.tscn")

export var _cname:String

func _init(sname:String = "Anonymous side", actionPoints:int = 0, cname:String = "Anonymous"):
	_cname = cname

# @param: game:Game
func execute(game):
	var side = .execute(game)
	side.addController(_Controller2DPackedScene.instance())

func copy():
	var copy = get_script().new(_sname, _actionPoints, _cname)
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPropagatedVersion():
	var ret = ModifierAddSide.new(_sname, _actionPoints)
	ret.silent = silent
	ret.propagate = propagate
	return ret
