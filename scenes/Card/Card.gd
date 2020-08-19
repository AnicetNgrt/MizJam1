extends Entity

class_name Card

export var label:String = ""
export(int,0,10) var weight:int = 0
export(int,0,999) var limitTurn:int = 0
export(int,0,999) var limitGame:int = 0

export(int,0,999) var playedTurn:int = 0 setget _set_playedTurn
export(int,0,999) var playedGame:int = 0 setget _set_playedGame

# @pre: 0 < value < Constants.INFINITY
func _set_playedTurn(value:int) -> void:
	playedTurn = value

# @pre: 0 < value < Constants.INFINITY
func _set_playedGame(value:int) -> void:
	playedGame = value

signal playedTurnChanged(card, new_value)
signal playedGameChanged(card, new_value)

func isPlayable() -> bool:
	return not isOverplayed()

func isOverplayed() -> bool:
	return not isOverplayedGame() and not isOverplayedTurn()

func isOverplayedGame() -> bool:
	return limitGame <= playedGame

func isOverplayedTurn() -> bool:
	return limitTurn <= playedTurn

# @pre: isPlayable() == true
func play() -> void:
	playedTurn -= 1
	playedGame -= 1

#func getNetworkingObject() -> Dictionary:
#	var object = .getNetworkingObject()
#	object.type = "Card"
#	object.weight = weight
#	object.limitTurn = limitTurn
#	object.limitGame = limitGame
#	object.playedTurn = playedTurn
#	object.playedGame = playedGame
#	return object
