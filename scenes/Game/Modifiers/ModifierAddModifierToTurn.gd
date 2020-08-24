extends Modifier

class_name ModifierAddModifierToTurn

export var _turnNum:int
export var _part:int
var _modifier
var _turn = null

func _ready():
	_modifier = get_child(0)
	_modifier.propagate = false

func _init(turnNum:int = 0, part:int = 1, modifier = null):
	_turnNum = turnNum
	_part = part
	if modifier != null:
		_modifier = modifier
		_modifier.propagate = false

# @param: game:Game
func execute(game):
	.execute(game)
	var _turn = game._timeline.getTurnOrNull(_turnNum)
	if _turn != null:
		if _modifier == null:
			_modifier = get_child(0)
			_modifier.propagate = false
		if _modifier.get_parent():
			_modifier.get_parent().remove_child(_modifier)
		if _turnNum == game._timeline.current_turn_num and _part == game._timeline.current_part:
			game._stack.add_child(_modifier)
		else:
			_turn.addModifier(_modifier,_part)

# @param: game:Game
func undo(game):
	.undo(game)

func copy():
	var copy = get_script().new(_turnNum, _part)
	if _modifier == null:
		_modifier = get_child(0)
		_modifier.propagate = false
	copy.add_child(_modifier.copy())
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
	if not is_inside_tree(): yield(self, "ready")
	if _modifier == null:
		_modifier = get_child(0)
		_modifier.propagate = false
	var prop = _modifier.getPropagatedVersion()
	var ret = get_script().new(_turnNum, _part)
	ret.add_child(prop)
	ret.silent = silent
	ret.propagate = propagate
	return ret
