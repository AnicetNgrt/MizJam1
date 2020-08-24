extends CenterContainer

class_name Card2D

onready var audioPlayer = $AudioStreamPlayer2D

var _card setget _set_card
func _set_card(val):
	_card = val
	if not is_inside_tree(): yield(self, "ready")

var toggledCrosses = []

var lastUpdate = OS.get_ticks_msec()

signal cardHovered(card2D)
signal cardNotHovered(card2D)

func _physics_process(delta):
	if audioPlayer.position != rect_position:
		audioPlayer.position = rect_position
	if OS.get_ticks_msec() - lastUpdate > 10:
		$Bottom/HBoxContainer/Cost.text = str(_card.cost)
		if _card.playTurnLeft() == 999:
			$Bottom/HBoxContainer/Cost3.text = "*"
		else:
			$Bottom/HBoxContainer/Cost3.text = str(_card.playTurnLeft())
		if _card.playGameLeft() == 999:
			$Bottom/HBoxContainer/Cost2.text = "*"
		else:
			$Bottom/HBoxContainer/Cost2.text = str(_card.playGameLeft())
		if _card is DisplacementCard:
			toggledCrosses = []
			for p in _card.pattern:
				toggledCrosses.append(p)
			toggleDisplacementMode(true)
		else:
			toggleDisplacementMode(false)
			toggledCrosses = []

func moveTo(position:Vector2, time = 1, playSound = true):
	$Tween.interpolate_property(self,"rect_position",rect_position,position,time,Tween.TRANS_SINE,Tween.EASE_OUT)
	$Tween.start()
	if playSound: audioPlayer.play()

func toggleDisplacementMode(toggle:bool):
	if toggle:
		$Top/DisplacementBg.show()
		$Top/MarginContainer.show()
		for c in toggledCrosses:
			$Top/MarginContainer/rows.get_node("cols"+str(3+c.y)+"/cell"+str(3+c.x)+"/cross").show()
	else:
		$Top/DisplacementBg.hide()
		$Top/MarginContainer.hide()
		for c in toggledCrosses:
			$Top/MarginContainer/rows.get_node("cols"+str(3+c.y)+"/cell"+str(3+c.x)+"/cross").hide()

func _on_Card2D_mouse_entered():
	emit_signal("cardHovered",self)

func _on_Card2D_mouse_exited():
	emit_signal("cardNotHovered",self)
