tool
extends CenterContainer

enum Sides {
	NEUTRAL,BLUE,RED
}

export(int) var num = 0 setget _set_num
func _set_num(val):
	num = val
	if not is_inside_tree(): yield(self,"ready")
	$VBoxContainer/Banner/Label.text = str(val)

export(Sides) var side1 = Sides.NEUTRAL setget _set_side1
func _set_side1(val):
	side1 = val
	if not is_inside_tree(): yield(self,"ready")
	match(val):
		Sides.NEUTRAL:
			$VBoxContainer/SubTurns/SubTurnNeutral.show()
			$VBoxContainer/SubTurns/SubTurnBlue.hide()
			$VBoxContainer/SubTurns/SubTurnRed.hide()
		Sides.BLUE:
			$VBoxContainer/SubTurns/SubTurnNeutral.hide()
			$VBoxContainer/SubTurns/SubTurnBlue.show()
			$VBoxContainer/SubTurns/SubTurnRed.hide()
		Sides.RED:
			$VBoxContainer/SubTurns/SubTurnNeutral.hide()
			$VBoxContainer/SubTurns/SubTurnBlue.hide()
			$VBoxContainer/SubTurns/SubTurnRed.show()

export(Sides) var side2 = Sides.NEUTRAL setget _set_side2
func _set_side2(val):
	side2 = val
	if not is_inside_tree(): yield(self,"ready")
	match(val):
		Sides.NEUTRAL:
			$VBoxContainer/SubTurns/SubTurnNeutral2.show()
			$VBoxContainer/SubTurns/SubTurnBlue2.hide()
			$VBoxContainer/SubTurns/SubTurnRed2.hide()
		Sides.BLUE:
			$VBoxContainer/SubTurns/SubTurnNeutral2.hide()
			$VBoxContainer/SubTurns/SubTurnBlue2.show()
			$VBoxContainer/SubTurns/SubTurnRed2.hide()
		Sides.RED:
			$VBoxContainer/SubTurns/SubTurnNeutral2.hide()
			$VBoxContainer/SubTurns/SubTurnBlue2.hide()
			$VBoxContainer/SubTurns/SubTurnRed2.show()
