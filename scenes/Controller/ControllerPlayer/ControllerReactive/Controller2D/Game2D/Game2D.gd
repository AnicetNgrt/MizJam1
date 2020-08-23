extends GameReactive

const _Pawn2DPackedScene = preload("res://scenes/2D/Pawn2D/Pawn2D.tscn")

onready var _turnIndicator = $ExtraIndicators/Top/TurnIndicator
onready var _audioClues = $AudioClues
onready var _pawnCarpet = $CarpetLayer/Carpet
onready var _turnSkip = $ExtraIndicators/Top/SkipContainer
onready var _dialogPopup = $Dialog 
onready var _dialogs = $Dialogs
onready var _tileCrosshair = $HighlightsTop/TileCrosshair
onready var _tileSelectionCrosshair = $HighlightsBottom/TileCrosshair

var _current_dialog = null
var _tile_hovered = null setget _set_tile_hovered
func _set_tile_hovered(val):
	_tile_hovered = val
	if not is_inside_tree(): yield(self, "ready")
	if val == null:
		_tileCrosshair.hide()
	else:
		_tileCrosshair.show()
		_tileCrosshair.position = val.getGlobalAnchorPos()

var _tile_selected = null setget _set_tile_selected
func _set_tile_selected(val):
	_tile_selected = val
	if not is_inside_tree(): yield(self, "ready")
	if val == null:
		_tileSelectionCrosshair.hide()
	else:
		_tileSelectionCrosshair.show()
		_tileSelectionCrosshair.kind = 4
		_tileSelectionCrosshair.position = val.getGlobalAnchorPos()

func addSide(side):
	.addSide(side)
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

func _on_Board_tile_hovered(tile):
	print(tile)
	self._tile_hovered = tile
	if _can_place_pawn_on_tile(tile):
		_tileCrosshair.kind = 2
	else:
		_tileCrosshair.kind = 1

func _on_Board_tile_not_hovered(tile):
	if tile == _tile_hovered:
		self._tile_hovered = null
