extends ModifierAddSide

class_name ModifierAddSideWith2DController

const _Controller2DPackedScene = preload("res://scenes/Controller/Controller2D/Controller2D.tscn")

export var _cname:String

func _init(sname:String = "Anonymous side", actionPoints:int = 0, cname:String = "Anonymous"):
	_cname = cname

# @param: game:Game
func execute(game):
	var side = .execute(game)
	side.get_node("Controllers").add_child(_Controller2DPackedScene.instance())

func copy():
	return get_script().new(_sname, _actionPoints, _cname)

func getPropagatedVersion():
	return ModifierAddSide.new(_sname, _actionPoints)
