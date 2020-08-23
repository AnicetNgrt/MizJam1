extends Node

class_name Game

const Rules = preload("res://resources/Rules.gd")
const _default_rules = preload("res://resources/default_rules.tres")

onready var _sides = $Sides
onready var _board = $Board
onready var _timeline = $Timeline
onready var _stack = $Stack

# @type: Modifier
var _lastModifier = null

export(Resource) var _rules = _default_rules setget _set_rules
func _set_rules(value:Rules) -> void:
	_rules = value

func _physics_process(delta):
	if _stack.get_child_count() > 0:
		var modifier = _stack.get_child(0)
		executeModifier(modifier)

func getTurnStartActionPoints() -> int:
	return _rules.actionPoints

# @param: modifier:Modifier
func executeModifier(modifier):
	if modifier.executed: return
	if modifier.get_parent():
		modifier.get_parent().remove_child(modifier)
	var part = _timeline.getThisTurnOrNull()
	if part != null:
		part.addModifier(modifier, _timeline.current_part)
	modifier.execute(self)
	modifier.previousModifier = _lastModifier
	_lastModifier = modifier
	if modifier.propagate: _spreadModifierToExecute(modifier)

func _spreadModifierToExecute(modifier):
	for c in _sides.get_children():
		if c is Side:
			c.spreadModifierToExecute(modifier.getPropagatedVersion())

# @param: modifier:Modifier
func undoModifier(modifier):
	if not modifier.executed: return
	modifier.undo(self)
	_lastModifier = modifier.previousModifier
	if modifier.propagate: _spreadModifierToUndo(modifier)

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
	side.connect("takesAction",self,"_on_side_takesAction")

# @param: turn:Turn
func addTurnToTimeline(turn):
	_timeline.addTurn(turn)

# @param: turn:Turn
func removeTurnFromTimeline(turn):
	_timeline.removeTurn(turn)

func gotoTurn(turnNum:int, part:int):
	_timeline.gotoTurnAndPart(turnNum, part)
	var turn = _timeline.getThisTurnOrNull()
	var stack = _timeline.getThisTurnPartStackOrNull()
	if stack != null and turn != null:
		var children = stack.get_children()
		for c in children:
			turn.removeModifier(c,stack.get_index()+1)
			_stack.add_child(c)

func consumeCard(sideNum:int, cardIndex:int):
	var card = _getCard(sideNum, cardIndex)
	card.consume()

func addActionPointsToSide(sideNum:int, count:int):
	_getSideByNum(sideNum).actionPoints += count
	if _getSideByNum(sideNum).actionPoints < 0:
		_getSideByNum(sideNum).actionPoints = 0

func removeActionPointsFromSide(sideNum:int, count:int):
	_getSideByNum(sideNum).actionPoints += count
	if _getSideByNum(sideNum).actionPoints < 0:
		_getSideByNum(sideNum).actionPoints = 0

# @pre: canAddPawnToSide(sideNum) == true
func addPawnToSide(sideNum:int,pawn:Pawn):
	_getSideByNum(sideNum).addPawn(pawn)

func canAddPawnToSide(sideNum:int) -> bool:
	return _getSideByNum(sideNum).getPawnCount() < _rules.maxPawnCountPerSide

func removePawnFromSide(sideNum:int,pawn:Pawn):
	_getSideByNum(sideNum).removePawn(pawn)

func placePawnTo(sideNum,pawnIndex,pos):
	var side = _getSideByNum(sideNum)
	var pawn = side.getPawns()[pawnIndex]
	pawn.position = pos

func _on_side_takesAction(side, action):
	if action.isValid(self, side):
		var modifiers = action.getModifiers(self, side)
		for m in modifiers:
			_stack.add_child(m)

func canPawnBePlaced(side, pawnIndex:int):
	var current = _timeline.getCurrentlyPlayingSideNumOrNull()
	var pawns = side.getPawns()
	if side.get_index()+1 != current or current == null: return false
	if not pawns.size() > pawnIndex: return false
	return true

func isTileFree(pos):
	if pos == Constants.UNPLACED_COORD: return true
	for s in _sides.get_children():
		var pawns = s.getPawns()
		for p in pawns:
			if p.getPosition() == pos: return false
	return true

# @pre: 1 <= sideNum <= 2
func _getSideByNum(sideNum:int) -> Side:
	return _sides.get_child(sideNum - 1)

func _getSideCount() -> int:
	return _sides.get_child_count()

func _getCard(sideNum, cardIndex):
	return _getSideByNum(sideNum).getCard(cardIndex)
