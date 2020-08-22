extends Modifier

class_name ModifierAddModifierToTurn

export var _turnNum:int
export var _part:int

func _init(turnNum:int = 0, part:int = 1, modifier:Modifier = Modifier.new()):
	_turnNum = turnNum
	_part = part
	if get_child_count() > 0:
		get_child(0).queue_free()
	add_child(modifier)

# @param: game:Game
func execute(game):
	.execute(game)
	pass

# @param: game:Game
func undo(game):
	.undo(game)
	pass

func copy():
	pass

func getPastDescription():
	return ""

func getFutureDescription():
	return ""

func getPropagatedVersion():
	return copy()
