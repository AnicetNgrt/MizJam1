extends Node2D

class_name Pawn2D

var isAlive = true
var pos = Constants.UNPLACED_COORD
var sideNum: int setget _set_sideNum
func _set_sideNum(val):
	if not is_inside_tree(): yield(self, "ready")
	if val == 1:
		$SpriteBlue.show()
		$SpriteRed.hide()
	elif val == 2:
		$SpriteBlue.hide()
		$SpriteRed.show()

func moveTo(anchorPos:Vector2):
	$Tween.interpolate_property(self,"position",position,anchorPos,0.5,Tween.TRANS_SINE,Tween.EASE_OUT)
	$Tween.start()
	$AudioStreamPlayer2D.play()

func getPosition():
	return pos
