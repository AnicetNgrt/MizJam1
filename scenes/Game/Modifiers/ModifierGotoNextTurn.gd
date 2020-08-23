extends Modifier

class_name ModifierGotoNextTurn

func _init():
	pass

# @param: game:Game
func execute(game):
	.execute(game)
	if game._timeline.current_part == 2:
		var mod = ModifierGotoTurn.new(game._timeline.current_turn_num+1,1)
		mod.propagate = true
		game.executeModifier(mod)
		
	else:
		var mod = ModifierGotoTurn.new(game._timeline.current_turn_num,2)
		mod.propagate = true
		game.executeModifier(mod)

# @param: game:Game
func undo(game):
	.undo(game)
	pass

func copy():
	var copy = get_script().new()
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
	return copy()
