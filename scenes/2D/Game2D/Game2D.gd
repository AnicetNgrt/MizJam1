extends Game

class_name Game2D

onready var _turnIndicator = $ExtraIndicators/Top/TurnIndicator

func addSide(side):
	.addSide(side)
	if _sides.get_child_count() >= 2:
		_timeline.side1Name = _sides.get_child(0).sname
		_timeline.side2Name = _sides.get_child(1).sname

func gotoTurn(turn:int, part:int):
	.gotoTurn(turn, part)
	_timeline.current_part = part
	_timeline.current_turn_num = turn
