extends Node

class_name Game

const Rules = preload("res://resources/Rules.gd")
const _default_rules = preload("res://resources/default_rules.tres")

onready var _sides = $Sides
onready var _board = $Board
onready var _timeline = $Timeline
onready var _initialStack = $InitialStack

var playingSideNum:int = 0
var currentTurn:int = 0
var currentPart:int = 0
# @type: Modifier
var _lastModifier = null

export(Resource) var _rules = _default_rules setget _set_rules
func _set_rules(value:Rules) -> void:
	_rules = value

func _ready():
	_executeInitialStack()

func startGame():
	if _getSideCount() >= 2:
		_initTurns()

func _executeInitialStack():
	for c in _initialStack.get_children():
		if c is Modifier:
			executeModifier(c)

func _initTurns():
	for i in range(0,_rules.maxTurnCount):
		_initTurn(i)

func _initTurn(num:int):
	var modifier = ModifierAddTurnToTimeline.new(num, _rules)
	executeModifier(modifier)

func getTurnStartActionPoints() -> int:
	return _rules.actionPoints

# @param: modifier:Modifier
func executeModifier(modifier):
	modifier.execute(self)
	modifier.previousModifier = _lastModifier
	_lastModifier = modifier
	if modifier.shallBePropagated(): _spreadModifierToExecute(modifier)

func _spreadModifierToExecute(modifier):
	for c in _sides.get_children():
		if c is Side:
			c.spreadModifierToExecute(modifier.getPropagatedVersion())

# @param: modifier:Modifier
func undoModifier(modifier):
	modifier.undo(self)
	_lastModifier = modifier.previousModifier
	if modifier.shallBePropagated(): _spreadModifierToUndo(modifier)

func _spreadModifierToUndo(modifier):
	for c in _sides.get_children():
		if c is Side:
			c.spreadModifierToUndo(modifier.getPropagatedVersion())

func undoModifierChain(count:int):
	while(_lastModifier != null and count > 0):
		count -= 1
		undoModifier(_lastModifier)

func configureSides(names:PoolStringArray):
	var i = 0
	for c in _sides.get_children():
		if c is Side:
			c.sname = names[i]
			i += 1

# @param: side:Side
func addSide(side):
	_sides.add_child(side)

# @param: turn:Turn
func addTurnToTimeline(turn):
	_timeline.addTurn(turn)

# @param: turn:Turn
func removeTurnFromTimeline(turn):
	_timeline.removeTurn(turn)

func gotoTurn(turnNum:int, part:int):
	currentTurn = turnNum
	currentPart = part

func addActionPointsToSide(sideNum:int, count:int):
	_getSideByNum(sideNum).actionPoints += count

func removeActionPointsFromSide(sideNum:int, count:int):
	_getSideByNum(sideNum).actionPoints += count

# @pre: canAddPawnToSide(sideNum) == true
func addPawnToSide(sideNum:int,pawn:Pawn):
	_getSideByNum(sideNum).addPawn(pawn)

func canAddPawnToSide(sideNum:int) -> bool:
	return _getSideByNum(sideNum).getPawnCount() < _rules.maxPawnCountPerSide

func removePawnFromSide(sideNum:int,pawn:Pawn):
	_getSideByNum(sideNum).removePawn(pawn)

# @pre: 1 <= sideNum <= 2
func _getSideByNum(sideNum:int) -> Side:
	return _sides.get_child(sideNum - 1)

func _getSideCount() -> int:
	return _sides.get_child_count()
