extends Modifier

class_name ModifierRefillApEachTurn

export var _actionPoints:int

func _init(actionPoints:int = 4):
	_actionPoints = actionPoints

# @param: game:Game
func execute(game):
	.execute(game)
	var _turnNums = game._timeline.getAllFutureAndPresentTurnNums()
	for num in _turnNums:
		for i in range(1,3):
			var playingSide = game._timeline.getPlayingSideNumDuringTurnsPartOrNull(num, i)
			if playingSide != null:
				var mod = ModifierAddModifierToTurn.new(num, i, ModifierGiveActionPoints.new(playingSide,_actionPoints))
				mod.propagate = false
				mod.silent = true
				mod.execute(game)

# @param: game:Game
func undo(game):
	.undo(game)

func copy():
	var copy = get_script().new(_actionPoints)
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return "Something happened, but there is no known detail about it."

func getFutureDescription():
	if silent: return ""
	return "Something will happen, but there is no known detail about it."

func getPropagatedVersion():
	return copy()
