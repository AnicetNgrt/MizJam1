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
		var innerA = ModifierSetPlayingSide.new(_sideA)
		var modA = ModifierAddModifierToTurn.new(num, 1, innerA)
		modA.propagate = false
		modA.silent = true
		var innerB = ModifierSetPlayingSide.new(_sideB)
		var modB = ModifierAddModifierToTurn.new(num, 2, innerB)
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
