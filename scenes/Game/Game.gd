extends Entity

class_name Game

const Rules = preload("res://resources/Rules.gd")
const _default_rules = preload("res://resources/default_rules.tres")

onready var _sides = []
onready var _board = $Board
onready var _timeline = $Timeline

var playingSideNum = 0

export(Resource) var _rules = _default_rules setget _set_rules
func _set_rules(value:Rules) -> void:
	_rules = value

func _ready():
	startGame()

func startGame():
	pass

func getTurnStartActionPoints() -> int:
	return _rules.actionPoints

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
