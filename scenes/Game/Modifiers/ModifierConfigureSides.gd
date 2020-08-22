extends Modifier

class_name ModifierConfigureSides

export var _names:PoolStringArray

func _init(names:PoolStringArray = []):
	_names = names

# @param: game:Game
func execute(game):
	.execute(game)
	game.configureSides(_names)

func copy():
	return get_script().new(_names)
