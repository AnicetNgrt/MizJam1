tool
extends CenterContainer

const _blueBg = preload("res://assets/turnIndicator/turnBlue.png")
const _redBg = preload("res://assets/turnIndicator/turnRed.png")

export var side1Name:String = "Side1" setget _set_side1Name
func _set_side1Name(val):
	side1Name = val
	_set_side(side)

export var side2Name:String = "Side2" setget _set_side2Name
func _set_side2Name(val):
	side2Name = val
	_set_side(side)

export var side:int = 0 setget _set_side
func _set_side(val):
	if not is_inside_tree(): yield(self,"ready")
	side = val
	match(side):
		0: 
			$TextureRect.hide()
			$LabelContainer/Label.hide()
		1: 
			$TextureRect.texture = _blueBg
			$TextureRect.show()
			$LabelContainer/Label.text = side1Name+"'s turn"
			$LabelContainer/Label.show()
		2: 
			$TextureRect.texture = _redBg
			$TextureRect.show()
			$LabelContainer/Label.text = side2Name+"'s turn"
			$LabelContainer/Label.show()
