extends Node

class_name CardEffect

static func getLabel() -> String:
	return ""

static func getDescription() -> String:
	return ""

export(int,0,10) var cost:int = 0

var gameRef:Game = null

func _init(_gameRef:Game):
	gameRef = _gameRef
