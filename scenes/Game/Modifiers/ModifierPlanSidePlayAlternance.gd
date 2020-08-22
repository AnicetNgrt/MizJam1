extends Modifier

class_name ModifierPlanSidePlayAlternance

export var _sideA:int
export var _sideB:int

func _init(sideA:int = 0, sideB:int = 0):
	_sideA = sideA
	_sideB = sideB

# @param: game:Game
func execute(game):
	.execute(game)
	var _turnNums = game._timeline.getAllFutureAndPresentTurnNums()
	for num in _turnNums:
		var modA = ModifierAddModifierToTurn.new(num, 1, ModifierSetPlayingSide.new(_sideA))
		modA.propagate = false
		modA.silent = true
		var modB = ModifierAddModifierToTurn.new(num, 2, ModifierSetPlayingSide.new(_sideB))
		modB.propagate = false
		modB.silent = true
		modA.execute(game)
		modB.execute(game)

# @param: game:Game
func undo(game):
	.undo(game)

func copy():
	var copy = get_script().new(_sideA,_sideB)
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	print(silent)
	if silent: return ""
	return "Something happened, but there is no known detail about it."

func getFutureDescription():
	if silent: return ""
	return "Something will happen, but there is no known detail about it."

func getPropagatedVersion():
	return copy()
