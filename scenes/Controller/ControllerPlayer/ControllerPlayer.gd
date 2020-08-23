extends ControllerSpectator

class_name ControllerPlayer

const _ActionSkipTurnPackedScene = preload("res://scenes/Action/Actions/ActionSkipTurn.tscn")
const _ActionPlacePawnPackedScene = preload("res://scenes/Action/Actions/ActionPlacePawn.tscn")

signal takesAction(action)

func _takeAction(action):
	emit_signal("takesAction",action)

func skipTurn():
	_takeAction(_ActionSkipTurnPackedScene.instance())

func placePawnOnTile(pawnIndex:int, pos:Vector2):
	var action = _ActionPlacePawnPackedScene.instance()
	action.pawnIndex = pawnIndex
	action.pos = pos
	_takeAction(action)
