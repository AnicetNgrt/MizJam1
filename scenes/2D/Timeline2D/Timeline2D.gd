extends Timeline

class_name Timeline2D

const _QueueTurnPackedScene = preload("res://scenes/2D/Timeline2D/QueueTurn.tscn")
const _LinePackedScene = preload("res://scenes/2D/Timeline2D/Line.tscn")

onready var _parts = $Body/Parts
onready var _bubble = $Body/BubbleContainer/Bubble
onready var _bubbleContainer = $Body/BubbleContainer
onready var _bubbleSpike = $Node2D/Spike
onready var _bubbleCategoryStart = $Body/BubbleContainer/Bubble/Body/Categories/Start
#onready var _bubbleCategoryPlay = $Body/BubbleContainer/Bubble/Body/Categories/Play
onready var _bubbleTitle = $Body/BubbleContainer/Bubble/Body/TitleContainer/TextMargin/Label
onready var _queueStart = $Body/Parts/QueueStartContainer/QueueStart
onready var _queueFinish = $Body/Parts/QueueFinish
onready var _nowIndicator = $Node2D/NowIndicator
onready var _nothingMessageLabel = $Body/BubbleContainer/Bubble/NothingMessageContainer/Label

var side1Name = "Side1"
var side2Name = "Side2"
var descriptions = {}

func _set_current_part(val):
	if not is_inside_tree(): yield(self, "ready")
	current_part = val
	_on_offset_or_current_changed()

func _set_current_turn_num(val):
	if not is_inside_tree(): yield(self, "ready")
	current_turn_num = val
	_on_offset_or_current_changed()

var offset = 0 setget _set_offset
func _set_offset(val):
	if not is_inside_tree(): yield(self, "ready")
	offset = val
	_on_offset_or_current_changed()

signal turn_hover_start(num, part)
signal turn_hover_stops(num, part)

func addTurn(turn):
	.addTurn(turn)
	turn.connect("modifierAdded",self,"_on_turnModifierAdded")
	var partNum = 0
	for part in turn.get_children():
		partNum += 1
		for modifier in part.get_children():
			_on_turnModifierAdded(modifier,turn.num,partNum)
	
	var turn2D = _QueueTurnPackedScene.instance()
	
	turn2D.side1 = turn.sideA
	turn2D.side2 = turn.sideB
	turn2D.num = turn.num
	turn2D.name = getTurnName(turn.num) + "2D"
	
	turn2D.connect("part_hover_starts",self,"_on_turn2D_part_hover_starts")
	turn2D.connect("part_hover_stops",self,"_on_turn2D_part_hover_stops")
	
	_parts.add_child(turn2D)
	
	if turn.num >= current_turn_num+offset and turn.num < current_turn_num+offset + 8:
		turn2D.show()
		if turn.num == current_turn_num:
			var now_position = _queueStart.rect_global_position + Vector2(-offset*34 + current_part*17 + 8,-2)
			_nowIndicator.position = now_position
			_nowIndicator.show()
	else:
		turn2D.hide()
	_parts.move_child(_parts.get_node("QueueFinish"),_parts.get_child_count())

func removeTurn(turn):
	.removeTurn(turn)
	_parts.remove_child(getTurnName(turn.num) + "2D")

func _on_turn2D_part_hover_starts(num:int, part:int):
	_show_bubble()
	
	var distance = num - (current_turn_num + offset + 3.5)
	_bubbleContainer.set("custom_constants/margin_left", distance * 20)
	var position = _parts.get_node(getTurnName(num) + "2D").get_node("VBoxContainer/SubTurns/SubTurnNeutral"+str(part)).get_global_rect().position
	if distance > 0:
		_bubbleSpike.flip_h = true
		_bubbleSpike.position = position + Vector2(4,-3)
	else:
		_bubbleSpike.flip_h = false
		_bubbleSpike.position = position + Vector2(10,-3)
	
	var title = ""
	if part == 1:
		title += side1Name
	elif part == 2:
		title += side2Name
	title += "'s "+str(num)
	if num % 100 < 10 or num % 100 > 19:
		match(num % 10):
			1:title += "st"
			2:title += "nd"
			3:title += "rd"
			_:title += "th"
	else:
		title += "th"
	title += " turn"
	_set_bubble_title(title)
	
	_clear_lines()
	_bubbleCategoryStart.hide()
	var count = 0
	if descriptions.has(str(num)) and descriptions[str(num)].has(str(part)):
		if num <= current_turn_num and part <= current_part:
			_bubbleCategoryStart.get_node("Label").text = " Events that already happened:"
			for desc in descriptions[str(num)][str(part)]:
				var desctext = desc["past"]
				if desctext != "":
					_add_start_line(desctext)
					count += 1
		else:
			_bubbleCategoryStart.get_node("Label").text = " Events that will happen:"
			for desc in descriptions[str(num)][str(part)]:
				var desctext = desc["future"]
				if desctext != "":
					_add_start_line(desctext)
					count += 1
		if count > 0:
			_bubbleCategoryStart.show()
	if count == 0 and num <= current_turn_num and part <= current_part:
		_nothingMessageLabel.text = "Nothing did happen this turn"
	elif count == 0:
		_nothingMessageLabel.text = "Nothing is planned to happen this turn"
	else:
		_nothingMessageLabel.text = ""
	
func _on_turn2D_part_hover_stops(num:int, part:int):
	_hide_bubble()

func _add_start_line(text:String):
	var line = _LinePackedScene.instance()
	line.text = text
	_bubbleCategoryStart.get_node("Lines").add_child(line)
	_bubbleCategoryStart.show()

func _set_bubble_title(title:String):
	_bubbleTitle.text = title

func _clear_lines():
	for c in _bubbleCategoryStart.get_node("Lines").get_children():
		c.queue_free()

func _show_bubble():
	_bubble.show()
	_bubbleSpike.show()

func _hide_bubble():
	_bubble.hide()
	_bubbleSpike.hide()

func _on_offset_or_current_changed():
	if current_turn_num + offset <= 0:
		offset = -current_turn_num
		_queueStart.disabled = true
	else:
		_queueStart.disabled = false
	
	var now_position = null
	for c in get_children():
		if c.name.begins_with("Turn"):
			var turn2D = _parts.get_node(getTurnName(c.num) + "2D")
			if c.num >= current_turn_num+offset and c.num < current_turn_num+offset + 8:
				turn2D.show()
				if c.num == current_turn_num:
					now_position = _queueStart.rect_global_position + Vector2(-offset*34 + current_part*17 + 8,-2)
			else:
				turn2D.hide()
	if now_position != null:
		_nowIndicator.position = now_position
		_nowIndicator.show()
	else:
		_nowIndicator.hide()

func _on_QueueStart_pressed():
	self.offset -= 1 #self in order to call setter

func _on_QueueFinish_pressed():
	self.offset += 1 #self in order to call setter

func _on_turnModifierAdded(modifier:Modifier,num:int,part:int):
	if not descriptions.has(str(num)):
		descriptions[str(num)] = {}
	if not descriptions[str(num)].has(str(part)):
		descriptions[str(num)][str(part)] = []
	descriptions[str(num)][str(part)].append({"past":modifier.getPastDescription(),"future":modifier.getFutureDescription()})

func _on_turnModifierRemoved(index:int,num:int,part:int):
	descriptions[num][part].remove(index)
