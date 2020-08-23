extends Game

class_name Game2D

const _ActionSkipTurnPackedScene = preload("res://scenes/Action/Actions/ActionSkipTurn.tscn")

onready var _turnIndicator = $ExtraIndicators/Top/TurnIndicator
onready var _audioClues = $AudioClues
onready var _turnSkip = $ExtraIndicators/Top/SkipContainer
onready var _dialogPopup = $Dialog 
onready var _dialogs = $Dialogs

var _current_dialog = null
var mySide = 0

signal takesAction(action)

func addSide(side):
	.addSide(side)
	if _sides.get_child_count() >= 2:
		_timeline.side1Name = _sides.get_child(0).sname
		_timeline.side2Name = _sides.get_child(1).sname
		_turnIndicator.side1Name = _sides.get_child(0).sname
		_turnIndicator.side2Name = _sides.get_child(1).sname

func executeModifier(modifier):
	.executeModifier(modifier)
	if modifier is ModifierSetPlayingSide:
		_onTurnSideChanged(modifier._sideNum)

func _onTurnSideChanged(sideNum):
	_turnIndicator.side = sideNum
	_audioClues.get_node("TurnPasses").play()
	if sideNum == mySide:
		_onMyTurn()
	else:
		_onNotMyTurn()

func _onMyTurn():
	_turnSkip.show()

func _onNotMyTurn():
	_turnSkip.hide()

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
	emit_signal("takesAction",_ActionSkipTurnPackedScene.instance())
