extends Node

class_name Game

const Rules = preload("res://resources/Rules.gd")
const _default_rules = preload("res://resources/default_rules.tres")

onready var _sides = []
onready var _board = $Board
onready var _timeline = $Timeline

var playingSideNum = 0
var currentTurn = 0

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
	var _turn = Turn.new(num,_rules)
	var _modifier = ModifierAddTurnToTimeline.new(_turn)
	executeModifier(_modifier)

func getTurnStartActionPoints() -> int:
	return _rules.actionPoints

func executeModifier(modifier:Modifier):
	pass

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
