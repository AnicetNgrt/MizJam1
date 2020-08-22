extends Modifier

class_name ModifierStartGame

func _init():
	pass

# @param: game:Game
func execute(game):
	.execute(game)
	game.startGame()
	pass

# @param: game:Game
func undo(game):
	.undo(game)

func shallBePropagated() -> bool:
	return false
