extends Controller

class_name ControllerSpectator

onready var _game = $Game

func executeModifier(modifier:Modifier):
	_game.executeModifier(modifier)

func undoModifier(modifier:Modifier):
	_game.undoModifier(modifier)
