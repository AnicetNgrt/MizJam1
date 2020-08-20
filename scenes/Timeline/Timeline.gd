extends Node

class_name Timeline

const Rules = preload("res://resources/Rules.gd")

export(int,0,999) var maxTurn

func getTurnName(num:int):
	return "Turn"+str(num)

func addTurn(turn:Turn):
	if has_node(getTurnName(turn.num)):
		get_node(getTurnName(turn.num)).queue_free()
	add_child(turn)
	turn.name = getTurnName(turn.num)

func removeTurn(turn:Turn):
	remove_child(turn)
