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
	if not isPlayable(): 
		print("overplay")
		return false
	var current = game._timeline.getCurrentlyPlayingSideNumOrNull()
	if not side.get_index()+1 == current: 
		print("not playing")
		return false
	if not side.get_index()+1 == sideNum:
		print("not owner")
		return false
	if not side.actionPoints >= cost: 
		print("no AP")
		return false
	return true

func isOverplayed() -> bool:
	return isOverplayedGame() or isOverplayedTurn()

func isOverplayedGame() -> bool:
	return limitGame <= playedGame

func isOverplayedTurn() -> bool:
	return limitTurn <= playedTurn

func isInterestedByPawn(game, sender, pawnSideNum, pawnIndex):
	return false

func assignPawn(sideNum, pawnIndex):
	pass

func isInterestedByTile(game, sender, pos):
	return false

func assignTile(pos):
	pass

func isInterestedByCard(game, sender, cardSideNum, cardIndex):
	return false

func assignCard(sideNum, pawnIndex):
	pass

func consume():
	playedTurn -= 1
	playedGame -= 1

func playTurnLeft():
	if limitTurn  == 999: return limitTurn
	return limitTurn - playedTurn

func playGameLeft():
	if limitGame  == 999: return limitGame
	return limitGame - playedGame

