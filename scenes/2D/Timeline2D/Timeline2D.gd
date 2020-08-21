extends Timeline

class_name Timeline2D

const _QueueTurnPackedScene = preload("res://scenes/2D/Timeline2D/QueueTurn.tscn")

func addTurn(turn):
	.addTurn(turn)
	var turn2D = _QueueTurnPackedScene.instance()
	turn2D.side1 = turn2D.Sides.BLUE
	turn2D.side2 = turn2D.Sides.RED
	turn2D.num = turn.num
	turn2D.name = getTurnName(turn.num) + "2D"
	$Parts.add_child(turn2D)
	if turn.num >= current_turn_num and turn.num < current_turn_num + 8:
		turn2D.show()
	else:
		turn2D.hide()
	$Parts.move_child($Parts/QueueFinish,$Parts.get_child_count())

func removeTurn(turn):
	.removeTurn(turn)
	$Parts.remove_child(getTurnName(turn.num) + "2D")
