extends Node

class_name Game

const Rules = preload("res://resources/Rules.gd")
const _default_rules = preload("res://resources/default_rules.tres")
const _TurnPackedScene = preload("res://scenes/Turn/Turn.tscn")

onready var _sides = []
onready var _board = $Board
onready var _timeline = $Timeline

var playingSideNum:int = 0
var currentTurn:int = 0
var _lastModifier:Modifier = null

export(Resource) var _rules = _default_rules setget _set_rules
func _set_rules(value:Rules) -> void:
	_rules = value

func _ready():
	startGame()

func startGame():
	_initTurns()

func _initTurns():
	for i in range(0,_rules.maxTurnCount):
		_initTurn(i)

func _initTurn(num:int):
	var turn:Turn = _TurnPackedScene.instance()
	turn._init(num, _rules)
	var modifier = ModifierAddTurnToTimeline.new(turn)
	executeModifier(modifier)

func getTurnStartActionPoints() -> int:
	return _rules.actionPoints

func executeModifier(modifier:Modifier):
	modifier.execute(self)
	modifier.previousModifier = _lastModifier
	_lastModifier = modifier

func undoModifier(modifier:Modifier):
	modifier.undo(self)
	_lastModifier = modifier.previousModifier

func undoModifierChain(count:int):
	while(_lastModifier != null and count > 0):
		count -= 1
		undoModifier(_lastModifier)

func addTurnToTimeline(turn:Turn):
	_timeline.addTurn(turn)

func removeTurnFromTimeline(turn:Turn):
	_timeline.removeTurn(turn)

func gotoTurn(turnNum:int):
	currentTurn = turnNum

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
	return _sides[sideNum-1]
