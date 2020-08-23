extends Highlightable

class_name Card

export var label:String = ""
export(int,0,10) var weight:int = 0
export(int,0,999) var limitTurn:int = 0
export(int,0,999) var limitGame:int = 0
export(int,0,10) var cost:int = 0
export(int) var sideNum = 0

export(int,0,999) var playedTurn:int = 0 setget _set_playedTurn
# @pre: 0 < value < Constants.INFINITY
func _set_playedTurn(value:int) -> void:
	playedTurn = value
	
export(int,0,999) var playedGame:int = 0 setget _set_playedGame
# @pre: 0 < value < Constants.INFINITY
func _set_playedGame(value:int) -> void:
	playedGame = value

signal playedTurnChanged(card, new_value)
signal playedGameChanged(card, new_value)

func isPlayable() -> bool:
	return not isOverplayed()

func isPlayableFor(game, side):
	if not isPlayable(): return false
	var current = game._timeline.getCurrentlyPlayingSideNumOrNull()
	if not side.get_index()+1 == current: return false
	if not side.get_index()+1 == sideNum: return false
	if not side.actionPoints >= cost: return false
	return true

func isOverplayed() -> bool:
	return not isOverplayedGame() and not isOverplayedTurn()

func isOverplayedGame() -> bool:
	return limitGame <= playedGame

func isOverplayedTurn() -> bool:
	return limitTurn <= playedTurn

func isInterestedByPawn(game, sender, sideNum, pawnIndex):
	return false

func assignPawn(sideNum, pawnIndex):
	pass

func isInterestedByTile(game, sender, pos):
	return false

func isInterestedByCard(game, sender, sideNum, cardIndex):
	pass

func assignCard(sideNum, pawnIndex):
	return false

func consume():
	playedTurn -= 1
	playedGame -= 1

# @pre: isPlayable() == true
func play(game, sender) -> void:
	pass
