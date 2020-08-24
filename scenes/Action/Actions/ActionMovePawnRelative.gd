extends Action

class_name ActionMovePawnRelative

export var pawnIndex:int
export var position:Vector2

func isValid(game, sender) -> bool:
	var pawns = sender.getPawns()
	if not pawns.size() >= pawnIndex: return false
	var pawn = pawns[pawnIndex]
	if not pawn.isAlive: return false
	if game._board.getTile(pawn.getPosition()) == null: return false
	var tile = game._board.getIncidentTile(pawn.getPosition()+position, pawn.getPosition())
	if tile == null: return false
	if not game.isTileFree(tile.position): return false
	return true

func getModifiers(game, sender):
	var pawns = sender.getPawns()
	var pawn = pawns[pawnIndex]
	var tile = game._board.getIncidentTile(pawn.getPosition()+position, pawn.getPosition())
	
	var child = get_child(0)
	child._sideNum = sender.get_index()+1
	child._pos = tile.position
	child._pawnIndex = pawnIndex
	remove_child(child)
	return [child]

func getNetworkObject():
	return {"name":"MovePawnRelative","pawnIndex":pawnIndex,"position_x":position.x,"position_y":position.y}
