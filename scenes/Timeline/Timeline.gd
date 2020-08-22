extends Node

class_name Timeline

const Rules = preload("res://resources/Rules.gd")

onready var _turns = {}

var current_part = 1 setget _set_current_part
func _set_current_part(val):
	current_part = val

var current_turn_num = 0 setget _set_current_turn_num
func _set_current_turn_num(val):
	current_turn_num = val

func getTurnName(num:int):
	return "Turn"+str(num)

func _ready():
	var count = 0
	for c in get_children():
		if c.name.begins_with("Turn"):
			count += 1
			c.num = count
			c.name = getTurnName(count)
			addTurn(c)
	pass

# @param: turn:Turn
func addTurn(turn):
	if not has_node(getTurnName(turn.num)) and not get_children().has(turn):
		add_child(turn)
	turn.name = getTurnName(turn.num)
	_turns[str(turn.num)] = turn

# @param: turn:Turn
func removeTurn(turn):
	var myturn = get_node(getTurnName(turn.num))
	remove_child(myturn)
	_turns.erase(str(myturn.num))

func gotoTurnAndPart(num, part):
	self.current_part = part
	self.current_turn_num = num

func getThisTurnPartStackOrNull():
	if _turns.has(str(current_turn_num)):
		if _turns[str(current_turn_num)].get_child_count() >= current_part:
			return _turns[str(current_turn_num)].get_child(current_part-1)
		else:
			return null
	else:
		return null

func getThisTurnOrNull():
	if _turns.has(str(current_turn_num)):
		return _turns[str(current_turn_num)]
	else:
		return null

func getCurrentlyPlayingSideNumOrNull():
	var part:Node = getThisTurnPartStackOrNull()
	if part == null: return null
	var side = null
	for c in part.get_children():
		if c is ModifierSetPlayingSide:
			side = c._sideNum
	return side

func getPlayingSideNumDuringTurnsPartOrNull(num:int, part:int):
	if _turns.has(str(num)):
		if _turns[str(num)].get_child_count() >= part:
			var partNode = _turns[str(num)].get_child(part-1)
			var side = null
			for c in partNode.get_children():
				if c is ModifierSetPlayingSide:
					side = c._sideNum
			return side
		else:
			return null
	else:
		return null

func getTurnOrNull(num:int):
	if _turns.has(str(num)):
		return _turns[str(num)]
	else:
		return null

func getAllTurnNums():
	var all = []
	for turn in _turns.values():
		all.append(turn.num)
	return all

func getAllFutureAndPresentTurnNums():
	var all = []
	for turn in _turns.values():
		if turn.num >= current_turn_num:
			all.append(turn.num)
	return all
