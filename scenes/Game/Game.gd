extends Entity

class_name Game

const Rules = preload("res://resources/Rules.gd")
const _default_rules = preload("res://resources/default_rules.tres")

onready var _sides = []
onready var _board = $Board
onready var _timeline = $Timeline

export(Resource) var rules = _default_rules setget _set_rules
func _set_rules(value:Rules) -> void:
	rules = value

func _ready():
	startGame()

func startGame():
	pass

# @pre: 1 <= sideNum <= 2
func removePawnToSide(sideNum:int,pawn:Pawn):
	_getSideByNum(sideNum).removePawn(pawn)

# @pre: 1 <= sideNum <= 2
# @pre: canAddPawnToSide(sideNum) == true
func addPawnToSide(sideNum:int,pawn:Pawn):
	_getSideByNum(sideNum).addPawn(pawn)

# @pre: 1 <= sideNum <= 2
func canAddPawnToSide(sideNum:int) -> bool:
	return _getSideByNum(sideNum).getPawnCount() < rules.maxPawnCountPerSide

# @pre: 1 <= sideNum <= 2
func _getSideByNum(sideNum:int) -> Side:
	return _sides[sideNum-1]
