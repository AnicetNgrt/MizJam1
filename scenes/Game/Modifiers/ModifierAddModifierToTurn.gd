extends Modifier

class_name ModifierAddModifierToTurn

export var _turnNum:int
export var _part:int
var _turn = null

func _init(turnNum:int = 0, part:int = 1, modifier:Modifier = Modifier.new()):
	_turnNum = turnNum
	_part = part
	if get_child_count() > 0:
		get_child(0).queue_free()
	add_child(modifier)
	modifier.propagate = false

# @param: game:Game
func execute(game):
	.execute(game)
	var _turn = game._timeline.getTurnOrNull(_turnNum)
	if _turn != null:
		var child = get_child(0)
		remove_child(child)
		if _turnNum == game._timeline.current_turn_num and _part == game._timeline.current_part:
			game._stack.add_child(child)
		else:
			_turn.addModifier(child,_part)

# @param: game:Game
func undo(game):
	.undo(game)
	if _turn != null:
		_turn.removeModifier(get_child(0),_part)
		_turn = null

func copy():
	var copy = get_script().new(_turnNum, _part, get_child(0).copy())
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return ""

func getFutureDescription():
	if silent: return ""
	return ""

func getPropagatedVersion():
	var ret = get_script().new(_turnNum, _part, get_child(0).getPropagatedVersion())
	ret.silent = silent
	ret.propagate = propagate
	return ret
