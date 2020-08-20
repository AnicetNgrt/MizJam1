extends Node

class_name Timeline

const Rules = preload("res://resources/Rules.gd")

func getTurnName(num:int):
	return "Turn"+str(num)

# @param: turn:Turn
func addTurn(turn):
	if has_node(getTurnName(turn.num)):
		get_node(getTurnName(turn.num)).queue_free()
	add_child(turn)
	turn.name = getTurnName(turn.num)

# @param: turn:Turn
func removeTurn(turn):
	remove_child(turn)
