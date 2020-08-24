extends Modifier

class_name ModifierRemoveApEndTurn

export var _starting:int

func _init(starting:int = 0):
	_starting = starting

# @param: game:Game
func execute(game):
	.execute(game)
	var _turnNums = game._timeline.getAllFutureAndPresentTurnNums()
	var lastPlayingSide = null
	for num in _turnNums:
		if num >= _starting:
			for i in range(1,3):
				var playingSide = game._timeline.getPlayingSideNumDuringTurnsPartOrNull(num, i)
				if lastPlayingSide != null:
					var modInside = ModifierGiveActionPoints.new(lastPlayingSide,-4)
					modInside.silent = true
					var mod = ModifierAddModifierToTurn.new(num, i)
					mod.propagate = false
					mod.silent = true
					mod.add_child(modInside)
					mod.execute(game)
				lastPlayingSide = playingSide

# @param: game:Game
func undo(game):
	.undo(game)

func copy():
	var copy = get_script().new(_starting)
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
