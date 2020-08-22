extends Node

class_name Side

onready var _controllers = $Controllers

export(String) var sname
export(int,0,999) var actionPoints: int

func getPawnCount() -> int:
	var count = 0
	for c in get_children():
		if c is Pawn:
			count += 1
	return count

func addPawn(pawn:Pawn):
	add_child(pawn)

func removePawn(pawn:Pawn):
	remove_child(pawn)

func spreadModifierToExecute(modifier:Modifier):
	for c in _getControllers():
		if c is ControllerSpectator:
			c.executeModifier(modifier.copy())

func spreadModifierToUndo(modifier:Modifier):
	for c in _getControllers():
		if c is ControllerSpectator:
			c.undoModifier(modifier.copy())

func _getControllers():
	return _controllers.get_children()
