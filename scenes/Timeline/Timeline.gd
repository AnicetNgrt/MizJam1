extends Node

class_name Timeline

const Rules = preload("res://resources/Rules.gd")

onready var _turns = {}

var current_turn_num = 0

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
