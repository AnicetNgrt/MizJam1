extends Node

class_name Side

onready var _controllers = $Controllers

export(String) var sname
export(int,0,999) var actionPoints: int

signal takesAction(side,action)

func getPawnCount() -> int:
	var count = 0
	for c in get_children():
		if c is Pawn or c is Pawn2D:
			count += 1
	return count

func addPawn(pawn):
	add_child(pawn)

func removePawn(pawn):
	remove_child(pawn)

func getPawns():
	var pawns = []
	for c in get_children():
		if c is Pawn or c is Pawn2D:
			pawns.append(c)
	return pawns

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

func getCard(index):
	return $HandStack.get_child(index)

func getHandCards(index):
	return $HandStack.get_children()

func getRemainingCards(index):
	return $RemainingStack.get_children()

func _on_controller_takes_action(action):
	emit_signal("takesAction",self,action)

func getUnplacedPawns():
	var pawns = []
	for p in getPawns():
		if p.getPosition() == Constants.UNPLACED_COORD:
			pawns.append(p)
	return pawns
