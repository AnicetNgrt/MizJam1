extends Node

class_name Timeline

export(int,0,999) var maxTurn

func _ready():
	for i in range(0,maxTurn):
		var name = "Turn"+str(i)
		if not has_node(name):
			var _created_turn = Node.new()
			add_child(_created_turn)
			_created_turn.name = name
		var _turn = get_node(name)
		if i % 2 == 0:
			pass
