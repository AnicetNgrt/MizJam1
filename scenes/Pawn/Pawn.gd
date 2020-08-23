extends Highlightable

class_name Pawn

var isAlive = true
var position = Constants.UNPLACED_COORD
var sideNum: int setget _set_sideNum
func _set_sideNum(val):
	sideNum = val

func getPosition():
	return position
