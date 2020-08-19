extends Node

class_name Timeline

const Rules = preload("res://resources/Rules.gd")

export(int,0,999) var maxTurn

func createAndAddTurns(rules:Rules):
	for i in range(0,maxTurn):
		if not has_node(getTurnName(i)):
			addTurn(Turn.new(i, rules))

func getTurnName(num:int):
	return "Turn"+str(num)

func addTurn(turn:Turn):
	add_child(turn)
	turn.name = getTurnName(turn.num)
