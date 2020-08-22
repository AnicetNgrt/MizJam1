extends Modifier

class_name ModifierRefillApEachTurn

export var _actionPoints:int
export var _starting:int

func _init(actionPoints:int = 4, starting:int = 0):
	_actionPoints = actionPoints
	_starting = starting

# @param: game:Game
func execute(game):
	.execute(game)
	var _turnNums = game._timeline.getAllFutureAndPresentTurnNums()
	for num in _turnNums:
		if num >= _starting:
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
	var copy = get_script().new(_actionPoints, _starting)
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
