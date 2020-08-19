extends Modifier

class_name ModifierAddPawn

var _game:Game
var _pawn:Pawn

func _init(game:Game,pawn:Pawn):
	_game = game
	_pawn = pawn

func execute():
	.execute()
	_game.add_child(_pawn)

func undo():
	.undo()
	_game.remove_child(_pawn)

#func getNetworkingObject() -> Dictionary:
#	var object = .getNetworkingObject()
#	object.type = "ModifierAddPawn"
#	object.entities["pawn"] = _pawn
#	return object
