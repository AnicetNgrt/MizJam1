extends CardStack

const _Card2DPackedScene = preload("res://scenes/2D/HandStack2D/Card2D.tscn")

signal cardSelected(card)

var _hovered_card = null
var _hovered_below = null

func getCardSlotAnchorGlobalPos(cardIndex:int):
	var middle_pos = $Anchor.rect_global_position
	var ref_index = (cardIndex % 6)+((6-min(6,$CardsLayer.get_child_count()))/2)
	var vec1 = middle_pos + Vector2(225/min(6,$CardsLayer.get_child_count())*(ref_index - 3),(floor(cardIndex/6)) * 65)
	return vec1 + Vector2(0,pow(vec1.x-middle_pos.x,2)/600-30)

func addCard(card):
	add_child(card)
	var card2D = _Card2DPackedScene.instance()
	card2D._card = card
	card2D.connect("cardHovered",self,"onCardHovered")
	card2D.connect("cardNotHovered",self,"onCardNotHovered")
	$CardsLayer.add_child(card2D)
	for c in $CardsLayer.get_children():
		if c is Card2D:
			c.moveTo(getCardSlotAnchorGlobalPos(c.get_index()))

func onCardHovered(card2D):
	if card2D == _hovered_card: return
	if card2D.get_index() >= 1:
		_hovered_below = $CardsLayer.get_child(card2D.get_index()-1)
	_hovered_card = card2D
	var pos = getCardSlotAnchorGlobalPos(_hovered_card.get_index())
	$CardsLayer.remove_child(card2D)
	$TopLayer.add_child(card2D)
	_hovered_card.moveTo(Vector2(0,-10)+pos,0.07,$CardsLayer.visible)

func onCardNotHovered(card2D):
	$TopLayer.remove_child(_hovered_card)
	if _hovered_below:
		$CardsLayer.add_child_below_node(_hovered_below,_hovered_card)
		_hovered_below = _hovered_below.get_index()
	else:
		$CardsLayer.add_child(_hovered_card)
		$CardsLayer.move_child(_hovered_card,0)
		_hovered_below = -1
	_hovered_card.moveTo(getCardSlotAnchorGlobalPos(_hovered_below+1),0.1,$CardsLayer.visible)
	_hovered_card = null
	_hovered_below = null

func getCard(index):
	return getHandCards()[index]

func getHandCards():
	var children = []
	for c in get_children():
		if c is Card:
			children.append(c)
	return children
