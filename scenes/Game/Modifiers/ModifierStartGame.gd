extends Modifier

class_name ModifierStartGame

func _init():
	pass

# @param: game:Game
func execute(game):
	.execute(game)
	game.startGame()

# @param: game:Game
func undo(game):
	.undo(game)
