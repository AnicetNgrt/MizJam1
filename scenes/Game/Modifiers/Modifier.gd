extends Node

class_name Modifier

var previousModifier:Modifier = null

# @param: game:Game
func execute(game):
	pass

# @param: game:Game
func undo(game):
	pass

#func getNetworkingObject() -> Dictionary:
#	var object = .getNetworkingObject()
#	object.type = "Modifier"
#	object.entities = {}
#	return object

func copy():
	return get_script().new()
