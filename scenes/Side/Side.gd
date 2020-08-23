extends Node

class_name Side

onready var _controllers = $Controllers

export(String) var sname
export(int,0,999) var actionPoints: int

signal takesAction(side,action)

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

func addController(controller):
	_controllers.add_child(controller)
	if controller is ControllerSpectator:
		controller.mySide = get_index()+1
	if controller is ControllerPlayer:
		controller.connect("takesAction",self,"_on_controller_takes_action")

func _on_controller_takes_action(action):
	emit_signal("takesAction",self,action)
