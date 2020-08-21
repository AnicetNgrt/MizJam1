extends Timeline

class_name Timeline2D

const _QueueTurnPackedScene = preload("res://scenes/2D/Timeline2D/QueueTurn.tscn")
const _LinePackedScene = preload("res://scenes/2D/Timeline2D/Line.tscn")

signal turn_hover_start(num, part)
signal turn_hover_stops(num, part)

func addTurn(turn):
	.addTurn(turn)
	var turn2D = _QueueTurnPackedScene.instance()
	turn2D.side1 = turn.sideA
	turn2D.side2 = turn.sideB
	turn2D.num = turn.num
	turn2D.name = getTurnName(turn.num) + "2D"
	turn2D.connect("part_hover_starts",self,"_on_turn2D_part_hover_starts")
	turn2D.connect("part_hover_stops",self,"_on_turn2D_part_hover_stops")
	$Body/Parts.add_child(turn2D)
	if turn.num >= current_turn_num and turn.num < current_turn_num + 8:
		turn2D.show()
	else:
		turn2D.hide()
	$Body/Parts.move_child($Body/Parts/QueueFinish,$Body/Parts.get_child_count())

func removeTurn(turn):
	.removeTurn(turn)
	$Body/Parts.remove_child(getTurnName(turn.num) + "2D")

func _on_turn2D_part_hover_starts(num:int, part:int):
	_show_bubble()

func _on_turn2D_part_hover_stops(num:int, part:int):
	_hide_bubble()

func _add_line(text:String):
	var line = _LinePackedScene.instance()
	line.text = text
	$Body/Bubble/Margin/Body/LinesScroller/Lines.add_child(line)

func _set_bubble_title(title:String):
	$Body/BubbleContainer/Bubble/Body/TitleContainer/TextMargin/Label.text = title

func _clear_lines():
	for c in $Body/Bubble/Margin/Body/LinesScroller/Lines.get_children():
		c.queue_free()

func _show_bubble():
	$Body/BubbleContainer/Bubble.show()

func _hide_bubble():
	$Body/BubbleContainer/Bubble.hide()
