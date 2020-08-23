extends Action

class_name ActionPlacePawn

export(int) var pawnIndex = 0
export(Vector2) var pos

func isValid(game, sender) -> bool:
	if not game.canPawnBePlaced(sender, pawnIndex): return false
	var pawn = sender.getPawns()[pawnIndex]
	#is from unplaced to placed or vice versa
	if not game.isTileFree(pos): return false
	if pos == Constants.UNPLACED_COORD and pawn.getPosition() == Constants.UNPLACED_COORD: return false
	if pos != Constants.UNPLACED_COORD and pawn.getPosition() != Constants.UNPLACED_COORD: return false
	return true

func getModifiers(game, sender):
	var child = get_child(0)
	child._sideNum = sender.get_index()+1
	child._pos = pos
	child._pawnIndex = pawnIndex
	remove_child(child)
	
	return [child]

func getNetworkObject():
	return {"name":"PlacePawn","pawnIndex":pawnIndex,"pos":pos}
