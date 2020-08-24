extends GameReactive

const _Pawn2DPackedScene = preload("res://scenes/2D/Pawn2D/Pawn2D.tscn")
const _HandStack2DPackedScene = preload("res://scenes/2D/HandStack2D/HandStack2D.tscn")

onready var _turnIndicator = $ExtraIndicators/Top/TurnIndicator
onready var _audioClues = $AudioClues
onready var _pawnCarpet = $CarpetLayer/Carpet
onready var _turnSkip = $ExtraIndicators/Top/SkipContainer
onready var _dialogPopup = $Dialog 
onready var _dialogs = $Dialogs
onready var _tileCrosshair = $HighlightsTop/TileCrosshair

var _current_dialog = null
var _tile_hovered = null setget _set_tile_hovered
var _tiles_highlighted = {}
var lastRefreshTime = OS.get_ticks_msec()

func _physics_process(delta):
	if OS.get_ticks_msec() - lastRefreshTime > 100 and mySide == _timeline.getCurrentlyPlayingSideNumOrNull():
		lastRefreshTime = OS.get_ticks_msec()
		var side = _getSideByNum(mySide)
		for tile in _board.getTiles():
			var highlighted = false
			var pawn = _getPawnOnTileOrNull(tile.position)
			for c in side.getHandCards():
				if c.isInterestedByTile(self,side,tile.position):
					if c is DisplacementCard:
						highlightTile(tile.position, c, "Tile", TileCrosshair.Kinds.MOVE)
						highlighted = true
						break
				if pawn:
					var pawnIndex = pawn.get_index()-3
					var sideNum = pawn.get_parent().get_index()+1
					if c.isInterestedByPawn(self,side,sideNum,pawnIndex):
						highlightTile(tile.position, c, "Pawn", TileCrosshair.Kinds.SELECTED)
						highlighted = true
						break
			if not highlighted: unHighLightTile(tile.position)

func _set_tile_hovered(val):
	print("hovered")
	_tile_hovered = val
	if not is_inside_tree(): yield(self, "ready")
	if val == null:
		_tileCrosshair.hide()
	else:
		_tileCrosshair.show()
		_tileCrosshair.position = val.getGlobalAnchorPos()

func highlightTile(pos, card, mode, style):
	if $HighlightsBottom.has_node(str(pos.x)+"|"+str(pos.y)): return
	var ch = TileCrosshair.new()
	ch.kind = style
	ch.name = str(pos.x)+"|"+str(pos.y)
	ch.position = _board.getTile(pos).getGlobalAnchorPos()
	_tiles_highlighted[str(pos.x)+"|"+str(pos.y)] = {
		"tile":_board.getTile(pos),
		"card":card,
		"mode":mode
	}
	$HighlightsBottom.add_child(ch)

func unHighLightTile(pos):
	if not $HighlightsBottom.has_node(str(pos.x)+"|"+str(pos.y)): return
	var ch = $HighlightsBottom.get_node(str(pos.x)+"|"+str(pos.y))
	_tiles_highlighted.erase(str(pos.x)+"|"+str(pos.y))
	if ch:
		$HighlightsBottom.remove_child(ch)
		ch.queue_free()

func addSide(side):
	.addSide(side)
	var handStack = side.get_node("HandStack")
	side.remove_child(handStack)
	var newHandStack = _HandStack2DPackedScene.instance()
	newHandStack.name ="HandStack"
	side.add_child_below_node(side.get_child(0),newHandStack)
	for c in handStack.get_children():
		handStack.remove_child(c)
		newHandStack.addCard(c)
		
	if _sides.get_child_count() >= 2:
		_timeline.side1Name = _sides.get_child(0).sname
		_timeline.side2Name = _sides.get_child(1).sname
		_turnIndicator.side1Name = _sides.get_child(0).sname
		_turnIndicator.side2Name = _sides.get_child(1).sname

func _onTurnSideChanged(sideNum):
	._onTurnSideChanged(sideNum)
	_turnIndicator.side = sideNum
	_audioClues.get_node("TurnPasses").play()

func _onMyTurn():
	._onMyTurn()

func _onNotMyTurn():
	._onNotMyTurn()

func addDialog(dialogContent):
	_dialogs.add_child(dialogContent)
	dialogContent.name = str(_dialogs.get_child_count())
	return str(_dialogs.get_child_count())

func readDialogFromName(_name:String):
	_current_dialog = _dialogs.get_node(_name)
	_readCurrentDialog()

func _readCurrentDialog():
	_dialogPopup.initFrom(_current_dialog)
	_dialogPopup.show()

func _on_Dialog_okPressed(dialog):
	if _current_dialog.get_child_count() > 0:
		_current_dialog = _current_dialog.get_child(0)
		_readCurrentDialog()
	else:
		_dialogPopup.hide()

func _on_RedButtonMedium_pressed():
	if get_parent() is ControllerPlayer:
		get_parent().skipTurn()

func _onPawnUnplaced(pawn):
	._onPawnUnplaced(pawn)
	_pawnCarpet.show()
	var pos = _pawnCarpet.getGlobalAnchorPosForPawn(pawn.get_index())
	if pawn.position != pos:
		pawn.moveTo(pos)

func addPawnToSide(sideNum:int,_pawn:Pawn):
	var pawn2D = _Pawn2DPackedScene.instance()
	pawn2D.sideNum = sideNum
	pawn2D.isAlive = _pawn.isAlive
	pawn2D.pos = _pawn.position	
	_getSideByNum(sideNum).addPawn(pawn2D)

func placePawnTo(sideNum,pawnIndex,pos):
	var side = _getSideByNum(sideNum)
	var pawn2D = side.getPawns()[pawnIndex]
	pawn2D.pos = pos
	pawn2D.moveTo(_board.getTile(pos).getGlobalAnchorPos())

func _onTurnCanBeSkipped():
	_turnSkip.show()

func _onTurnCantBeSkipped():
	_turnSkip.hide()

func _on_Board_tile_clicked(tile):
	if _can_place_pawn_on_tile(tile):
		if get_parent() is ControllerPlayer:
			get_parent().placePawnOnTile(_get_lastUnplacedPawnIndex(),tile.position)
	if _tiles_highlighted.has(str(tile.position.x)+"|"+str(tile.position.y)):
		var hl = _tiles_highlighted[str(tile.position.x)+"|"+str(tile.position.y)]
		if hl["mode"] == "Tile":
			hl["card"].assignTile(tile.position)
		elif hl["mode"] == "Pawn":
			var pawn = _getPawnOnTileOrNull(tile.position)
			var pawnIndex = pawn.get_index()-3
			var sideNum = pawn.get_parent().get_index()+1
			hl["card"].assignPawn(sideNum, pawnIndex)

func _on_Board_tile_hovered(tile):
	self._tile_hovered = tile
	if _can_place_pawn_on_tile(tile):
		_tileCrosshair.kind = 2
	else:
		_tileCrosshair.kind = 0

func _on_Board_tile_not_hovered(tile):
	if tile == _tile_hovered:
		self._tile_hovered = null
